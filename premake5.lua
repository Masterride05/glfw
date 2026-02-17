project "GLFW"
    kind "StaticLib"
    language "C"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    files {
        "src/**.c",
        "include/**.h"
    }

    includedirs {
        "include"
    }

    filter "system:windows"
        staticruntime "on"
        systemversion "latest"
        defines { "_GLFW_WIN32" }
        files {
            "src/win32_*.c",
            "src/wgl_context.c"
        }

    filter "system:linux"
        pic "On"
        defines { "_GLFW_X11" }
        files {
            "src/x11_*.c",
            "src/glx_context.c"
        }
        links { "X11", "GL", "pthread", "dl" }

    filter {}
