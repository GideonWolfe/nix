# Add source and target for edges
label_replace(
  label_replace(
    sum by (service) (rate(traefik_service_requests_total[5m])),
    "source", "traefik", "", ""
  ),
  "target", "$1", "service", "(.*)"
)