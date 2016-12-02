from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext
import numpy
import os

# to use this script to compile code, run
# python setup.py build_ext --inplace
ext_modules = [Extension("PicoHarp300",
                         ["PicoHarp300.pyx"],
                         libraries=["phlib"],
                         library_dirs=["."],
                         include_dirs=[numpy.get_include()]),
               ]

setup(
  name = 'Cython library for interfacing with the PicoHarp 300',
  cmdclass = {'build_ext': build_ext},
  ext_modules = ext_modules
)
