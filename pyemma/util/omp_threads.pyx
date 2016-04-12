from __future__ import print_function

import omp_threads as omp
cimport omp_threads as omp

def get_num_threads():
    return int(omp.omp_get_num_threads())

class num_threads(object):
    """
    Set the thread context:

    >>> print("Before ", get_num_threads()) # doctest: +ELLIPSIS
    Before ...
    >>> with num_threads(2):
    ...     print( "In thread context: ", get_num_threads())
    In thread context: 2
    >>> print("After ", get_num_threads()) # doctest: +ELLIPSIS
    After ...
    """

    def __init__(self, num_threads):
        self._old_num_threads = int(omp.omp_get_num_threads())
        self.num_threads = num_threads

    def __enter__(self):
        cdef int i = self.num_threads
        omp.omp_set_num_threads(i)

    def __exit__(self, *args):
        cdef int i = self._old_num_threads
        omp.omp_set_num_threads(i)

