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
    // Fix for flutter_keyboard_visibility and other packages missing namespace
    afterEvaluate {
        if (plugins.hasPlugin("com.android.library")) {
            val androidExt = extensions.findByName("android") as? com.android.build.gradle.LibraryExtension
            if (androidExt != null && androidExt.namespace == null) {
                androidExt.namespace = "com.example.${project.name}"
            }
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
