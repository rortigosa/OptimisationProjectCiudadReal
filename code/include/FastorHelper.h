#include "Fastor.h"
using namespace Fastor;

template<typename T, size_t ... Dims>
void copy_matlab(Tensor<T,Dims...> &A, const T* A_np, size_t offset=0) {
    std::copy(A_np,A_np+A.size(),A.data());
}


template<typename T, size_t ... Dims>
void copy_fastor(T* A_np, const Tensor<T,Dims...> &A, size_t offset=0) {
    std::copy(A.data(),A.data()+A.size(),A_np+offset);
}
