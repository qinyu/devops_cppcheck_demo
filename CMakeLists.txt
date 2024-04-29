cmake_minimum_required(VERSION 3.10)

project(MyProject)

# 添加Cppcheck作为构建的一部分
find_program(CPPCHECK_EXECUTABLE NAMES cppcheck)
if(CPPCHECK_EXECUTABLE)
    # 设置Cppcheck的参数
    set(CPPCHECK_PARAMS "--enable=all" "--error-exitcode=10")

    # 在构建时运行Cppcheck
    add_custom_target(
        cppcheck
        COMMAND ${CPPCHECK_EXECUTABLE} ${CPPCHECK_PARAMS} ${CMAKE_SOURCE_DIR}/src
        COMMENT "Running Cppcheck"
    )

    message(STATUS "Cppcheck result: ${CPPCHECK_RESULT}")

    # 如果Cppcheck发现了警告或错误，则停止编译
    if(CPPCHECK_RESULT)
        message(FATAL_ERROR "Cppcheck found errors. Fix them before continuing.")
    endif()
endif()

# 添加您的源文件
add_executable(my_executable src/main.cpp)

# 将Cppcheck添加到构建目标中
add_dependencies(my_executable cppcheck)
