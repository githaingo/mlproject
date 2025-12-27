
from  setuptools import find_packages, setup
from typing import List
import os

HYPHEN_E_DOT = '-e .'

def get_requirements(file_path:str)->List[str]:
    if not os.path.exists(file_path):
        return []
    
    requirements=[]
    with open(file_path) as file_obj:
        requirements= file_obj.readlines()
        requirements=[req.strip() for req in requirements]
        
        if HYPHEN_E_DOT in requirements:
            requirements.remove(HYPHEN_E_DOT)
    
    return requirements

setup(
    name='mlproject',
    version='0.0.1',
    author='RANDRIANINDRINA HAINGOTIANA',
    author_email='poupousyh@gmail.com',
    packages= find_packages(where='src'),
    package_dir={'': 'src'},
    install_requires = get_requirements('requirements.txt')
)
