{ lib, modulesPath, pkgs, config, ... }: {

  services.tempo = {
    enable = true;

    settings = {
      server = {
        http_listen_port = config.local.world.hosts.monitor.tempo.port;
        grpc_listen_port = 9096; # Explicitly set to avoid conflict with Loki on 9095
      };

      distributor = {
        receivers = {
          jaeger = {
            protocols = {
              thrift_http = {
                endpoint = "0.0.0.0:14268";
              };
              grpc = {
                endpoint = "0.0.0.0:14250";
              };
            };
          };
          otlp = {
            protocols = {
              grpc = {
                endpoint = "0.0.0.0:4317";
              };
              http = {
                endpoint = "0.0.0.0:4318";
              };
            };
          };
        };
      };

      # ingester.max_block_duration = "5m" is the default, removing redundant config
      
      compactor = {
        compaction = {
          block_retention = "1h";
        };
      };

      storage = {
        trace = {
          backend = "local";
          local = {
            # path defaults to /var/lib/tempo/traces, but since NixOS sets StateDirectory = "tempo"
            # we should use the working directory relative path
            path = "./traces";
          };
          wal = {
            # path defaults to /var/lib/tempo/wal, using relative path
            path = "./wal";
          };
        };
      };

      # Query frontend configuration - enables search functionality
      query_frontend = {
        search = {
          # The number of concurrent jobs to execute when searching the backend (default: 1000)
          concurrent_jobs = 1000;
          
          # The target number of bytes for each job to handle when performing a backend search (default: 100MB)
          target_bytes_per_job = 104857600; # 100MB
          
          # Limit used for search requests if none is set by the caller (default: 20)
          default_result_limit = 20;
          
          # The maximum allowed value of the limit parameter on search requests (default: 0 = disabled)
          max_result_limit = 0;
          
          # The maximum allowed time range for a search (default: 168h = 7 days)
          max_duration = "168h";
          
          # Time ranges before this will be searched in ingesters only (default: 15m)
          query_backend_after = "15m";
          
          # Time ranges after this will be searched in backend only (default: 30m)
          query_ingesters_until = "30m";
        };
      };
      # Metrics generator configuration with service graphs enabled
      metrics_generator = {
        # Processor configuration - enables service graphs for service map visualization
        processor = {
          service_graphs = {
            # How long to wait for an edge to be completed (default: 10s)
            wait = "10s";
            
            # Maximum number of edges stored in memory (default: 10000)
            max_items = 10000;
            
            # Number of workers processing edges (default: 10)
            workers = 10;
            
            # Histogram buckets for latency measurements in seconds
            histogram_buckets = [ 0.1 0.2 0.4 0.8 1.6 3.2 6.4 12.8 ];
            
            # Additional dimensions to include in metrics (from span/resource attributes)
            dimensions = [ ];
            
            # Enable client/server prefix for additional dimensions
            enable_client_server_prefix = false;
            
            # Enable messaging system latency histogram for pub/sub patterns
            enable_messaging_system_latency_histogram = false;
            
            # Attributes used to create peer edges (external services)
            # Order matters - first match is used as the node name
            peer_attributes = [ "peer.service" "db.name" "db.system" ];
            
            # Enable virtual node labels to distinguish uninstrumented services
            enable_virtual_node_label = true;
          };
          
          # Local blocks processor - required for TraceQL metrics and Grafana Traces Drilldown
          local_blocks = {
            # How often to flush completed traces and blocks
            flush_check_period = "10s";
            
            # A trace is considered complete after this period of inactivity
            trace_idle_period = "10s";
            
            # Maximum duration before cutting a block
            max_block_duration = "1m";
            
            # Maximum size of a block before cutting it
            max_block_bytes = 500000000; # 500MB
            
            # Duration to keep blocks after flushing
            complete_block_timeout = "1h";
            
            # Maximum number of live traces (0 = unlimited)
            max_live_traces = 0;
            
            # Filter to only include server spans (reduces storage)
            filter_server_spans = true;
            
            # Flush blocks to storage for historical TraceQL queries
            flush_to_storage = true;
            
            # Number of blocks processed concurrently
            concurrent_blocks = 10;
          };
        };
        
        storage = {
          path = "./generator/wal";
          remote_write = [
            {
              url = "${config.local.world.hosts.monitor.prometheus.protocol}://localhost:${toString config.local.world.hosts.monitor.prometheus.port}/api/v1/write";
            }
          ];
        };
      };

      # Overrides to enable metrics generator processors
      overrides = {
        defaults = {
          metrics_generator = {
            # Temporarily disable local-blocks to test service-graphs only
            processors = [ "service-graphs" "local-blocks"];
          };
        };
      };
    };
  };

  # Open firewall ports for Tempo
  networking.firewall.allowedTCPPorts = [ 
    config.local.world.hosts.monitor.tempo.port  # HTTP API (3200)
    9096  # gRPC API (default, keeping for external access)
    14268 # Jaeger HTTP
    14250 # Jaeger gRPC
    4317  # OTLP gRPC
    4318  # OTLP HTTP
  ];

  # Traefik routing for Tempo
  services.traefik.dynamicConfigOptions.http.routers.tempo = {
    rule = "Host(`${config.local.world.hosts.monitor.tempo.domain}`)";
    service = "tempo";
    entryPoints = [ "http" "https" ];
    tls.domains = [{ main = "*.gideonwolfe.xyz"; }];
    tls.certResolver = "myresolver";
  };

  services.traefik.dynamicConfigOptions.http.services.tempo = {
    loadBalancer = {
      passHostHeader = true;
      servers = [{ url = "http://${config.local.world.hosts.monitor.ip}:${toString config.local.world.hosts.monitor.tempo.port}"; }];
    };
  };
}