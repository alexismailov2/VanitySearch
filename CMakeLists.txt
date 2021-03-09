cmake_minimum_required(VERSION 3.14)
project(VanitySearch)

find_package(CUDA REQUIRED)

set(CUDA_NVCC_FLAGS ${CUDA_NVCC_FLAGS}; -O3 -gencode arch=compute_75,code=sm_75)

enable_language("CUDA")

add_definitions(-DWITHGPU)

if(MSVC)
    add_definitions(-DWIN64)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /arch:SSSE3 /O2")
else()
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -m64 -mssse3 -Wno-write-strings -O2")
endif()

set(VANITY_SEARCH_SOURCES
        Base58.cpp
        IntGroup.cpp
        main.cpp
        Random.cpp
        Timer.cpp
        Int.cpp
        IntMod.cpp
        Point.cpp
        SECP256K1.cpp
        Vanity.cpp
        GPU/GPUGenerate.cpp
        hash/ripemd160.cpp
        hash/sha256.cpp
        hash/sha512.cpp
        hash/ripemd160_sse.cpp
        hash/sha256_sse.cpp
        Bech32.cpp
        Wildcard.cpp)

set(VANITY_SEARCH_GPU_SOURCE
        GPU/GPUEngine.cu)

add_executable(${PROJECT_NAME}
        ${VANITY_SEARCH_SOURCES}
        ${VANITY_SEARCH_GPU_SOURCE})

set_target_properties(${PROJECT_NAME}
        PROPERTIES CUDA_SEPARABLE_COMPILATION ON)

if (MSVC)
        set(PTHREAD_LIB)
else()
        set(PTHREAD_LIB pthread)
endif()

target_link_libraries(${PROJECT_NAME}
        ${PTHREAD_LIB}
        ${CUDA_LIBS})