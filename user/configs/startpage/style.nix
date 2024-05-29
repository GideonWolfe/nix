{lib, config, pkgs, ... }:

with config.lib.stylix.colors.withHashtag;

{


	home.file = {

		# Creating the CSS file to theme the startpage
		"nix/user/configs/startpage/data/style.css" = {
			text = ''

:root {
    --branch: 1px solid ${base0B};
}


body {
    background: ${base00};
}

.container {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
}

.prompt {
    /* font-family: var(--font); */
    color: ${base0C};
}

.prompt~.prompt {
    padding: 1.5rem 0 0.3125rem;
}

span {
    color: ${base0A};
}

h1 {
    display: inline;
    /* font-family: var(--font); */
    font-size: 1rem;
    font-weight: normal;
    color: ${base08};
}

.tree > ul {
    margin: 0;
    padding-left: 1rem;
    padding-right: 1rem;
}

ul {
    list-style: none;
    padding-left: 2.5rem;
    white-space:nowrap;
}

li {
    position: relative;
}

li::before, li::after {
    content: "";
    position: absolute;
    left: -0.75rem;
}

li::before {
    border-top: var(--branch);
    top: 0.75rem;
    width: 0.5rem;
}

li::after {
    border-left: var(--branch);
    height: 100%;
    top: 0.25rem;
}

li:last-child::after {
    height: 0.5rem;
}

a {
    /* font-family: var(--font); */
    font-size: 1rem;
    color: ${base0B};
    text-decoration: none;
    outline: none;
}

a:hover {
    color: ${base0F};
    background: ${base00};
}

form h1 {
    padding-left: 0.125rem;
}

input {
    /* font-family: var(--font); */
    font-size: 1rem;
    color: ${base04};
    background-color: ${base00};
    border-width: 1px;
    border-color: ${base0D};
    border-style: solid;
    padding-top: 4px;
    padding-bottom: 4px;
}

.column {
  flex: 50%;
  padding: 5px;
}

.row {
  display: flex;
}

.row:after {
  content: "";
  display: table;
  clear: both;
}
			'';
		};

	};



}
