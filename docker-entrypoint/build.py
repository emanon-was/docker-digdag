from jinja2 import Template, Environment, FileSystemLoader
import toml

digdag_server_config = toml.load(open('digdag-server.toml'))

template_env = Environment(loader=FileSystemLoader('templates'))
template = template_env.get_template('docker-entrypoint.sh.j2')

print(template.render(conf=digdag_server_config))
