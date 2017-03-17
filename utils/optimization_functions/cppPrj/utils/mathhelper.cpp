#include "mathhelper.h"
/*
    References:
    http://stackoverflow.com/questions/115703/storing-c-template-function-definitions-in-a-cpp-file
    http://en.cppreference.com/w/cpp/algorithm/accumulate
*/

template<typename T>
T MathHelper<T>::SumVec(const Tensor<T> &in){
    vector<T> inVec = in.GetBufferCopy();
    T res = accumulate(inVec.begin(), inVec.end(),0);
    return res;
}

template<typename T>
T MathHelper<T>::ProdVec(const Tensor<T> &in){
    vector<T> inVec = in.GetBufferCopy();
    T res = accumulate(inVec.begin(), inVec.end(),1,multiplies<T>());
    return res;
}

template<typename T>
Tensor<T> MathHelper<T>::Log(const Tensor<T> &in){
    Tensor<T> result(vector<int>({in.GetDims()}));

    // Get a reference to the result tensor buffer
    vector<T> &resVec = result.GetBufferRef();

    // For each element of m_buffer multiply by b and store the result on resVec
    //transform(m_buffer.begin(), m_buffer.end(), resVec.begin(),std::bind1st(std::multiplies<T>(),b));
    return result;
}

// Explicit template instantiation
template class MathHelper<float>;
template class MathHelper<double>;
template class MathHelper<int>;
