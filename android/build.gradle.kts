allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
    plugins.withId("com.android.library") {
        pluginManager.apply("org.jetbrains.kotlin.android")
    }
}

subprojects {
    val updateAndroid = {
        if (project.name == "syncfusion_flutter_pdfviewer") {
            val android = project.extensions.findByName("android")
            if (android != null) {
                try {
                    val method = android.javaClass.getMethod("compileSdkVersion", Int::class.javaPrimitiveType)
                    method.invoke(android, 36)
                } catch (e: Exception) {
                    try {
                        val method = android.javaClass.getMethod("setCompileSdkVersion", Int::class.javaPrimitiveType)
                        method.invoke(android, 36)
                    } catch (ignored: Exception) {}
                }
            }
        }
    }

    if (project.state.executed) {
        updateAndroid()
    } else {
        project.afterEvaluate { updateAndroid() }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
