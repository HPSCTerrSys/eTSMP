set(PF_CFLAGS "-qopenmp -Wall -Werror")
set(PF_LDFLAGS "-lcudart -lcusparse -lcurand")

find_package(NetCDF REQUIRED)
find_package(Hypre REQUIRED)

ExternalProject_Add(ParFlow
    PREFIX      ParFlow
    SOURCE_DIR  ${PARFLOW_SRC}
    CMAKE_ARGS  -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
                -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
                -DCMAKE_Fortran_COMPILER=${CMAKE_Fortran_COMPILER}
                -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
                -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
                -DPARFLOW_AMPS_LAYER=oas3
                -DOAS3_ROOT=${OASIS_ROOT}
                -DNETCDF_DIR=${NetCDF_ROOT}
                -DPARFLOW_AMPS_SEQUENTIAL_IO=on
                -DPARFLOW_HAVE_ECLM=ON
                -DHYPRE_ROOT=${HYPRE_ROOT}
                -DPARFLOW_ENABLE_TIMING=TRUE
                -DPARFLOW_ENABLE_SLURM=TRUE
                -DMPIEXEC_EXECUTABLE=srun        # TODO: replace with variable!
                -DMPIEXEC_NUMPROC_FLAG=--ntasks
                -DCMAKE_C_FLAGS=${PF_CFLAGS}
                -DCMAKE_EXE_LINKER_FLAGS=${PF_LDFLAGS}
)