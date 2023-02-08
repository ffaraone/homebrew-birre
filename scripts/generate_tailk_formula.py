import os

from jinja2 import Environment, FileSystemLoader
from poet import make_graph

def generate():
    graph = make_graph('tailk')
    resources = [
        value 
        for key, value in graph.items()
        if key != 'tailk'
    ]

    pkg_info = graph['tailk']
    if os.path.exists('digest.txt'):
        with open('digest.txt', 'r') as f:
            digest = f.read()
            if digest == pkg_info['checksum']:
                print(f'Formula for version {pkg_info["version"]} already exists')
                return
    
    with open('digest.txt', 'w') as f:
        f.write(pkg_info['checksum'])

    env = Environment(
        loader=FileSystemLoader(searchpath='./scripts'),
        trim_blocks=True,
    )
    
    template = env.get_template('tailk.rb.j2')
    formula = template.render(
        root_url=pkg_info['url'],
        root_version=pkg_info['version'],
        root_digest=pkg_info['checksum'],
        resources=resources,
    )
    with open(f'Formula/tailk.rb', 'w') as f:
        f.write(formula)
    
    print(f'Formula for version {pkg_info["version"]} has been generated!')



if __name__ == '__main__':
    generate()
