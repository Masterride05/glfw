project "GLFW"
    kind "SharedLib"
    language "C"
    staticruntime "off"

    targetdir ("bin/" .. outputdir)
    objdir ("bin-int/" .. outputdir)

    files {
        "src/**.c",
        "include/**.h"
    }

    includedirs {
        "include"
    }

    filter "system:windows"
        multiprocessorcompile ("on")
        systemversion "latest"

        defines {
            "_GLFW_WIN32",
            "_CRT_SECURE_NO_WARNINGS",
            "_GLFW_BUILD_DLL"
        }

        files {
            "src/win32_*.c",
            "src/wgl_context.c"
        }
        links {
            "gdi32",
            "user32",
            "shell32",
            "opengl32"
        }
        postbuildcommands {
            { "{MKDIR} %{wks.location}bin/" .. outputdir, 
            "{COPYFILE} %{cfg.buildtarget.abspath} %{wks.location}bin/" .. outputdir },
        }

    filter "system:linux"
        pic "On"
        defines { 
            "_GLFW_X11",
            "_GLFW_BUILD_DLL" 
        }
        files {
            "src/x11_*.c",
            "src/glx_context.c"
        }

        links {
            "X11",
            "Xrandr",
            "Xi",
            "dl",
            "pthread",
            "GL"
        }

    filter {}