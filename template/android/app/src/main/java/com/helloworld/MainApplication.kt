package com.helloworld

import android.app.Application
import android.content.Context
import com.facebook.react.*
import com.facebook.soloader.SoLoader
import java.lang.Exception
import java.lang.reflect.InvocationTargetException

@Suppress("unused")
class MainApplication: Application(), ReactApplication {
    private val reactNativeHost = object: ReactNativeHost(this) {
        override fun getUseDeveloperSupport(): Boolean {
            return BuildConfig.DEBUG
        }

        override fun getPackages(): MutableList<ReactPackage> {
            @Suppress("UnnecessaryVariable")
            val packages = PackageList(this).packages
            // Packages that cannot be autolinked yet can be added manually here, for example:
            // packages.add(MyReactNativePackage())
            return packages
        }

        override fun getJSMainModuleName(): String {
            return "index"
        }
    }

    override fun getReactNativeHost(): ReactNativeHost {
        return reactNativeHost
    }

    override fun onCreate() {
        super.onCreate()
        SoLoader.init(this, /* native exopackage */ false)
        initializeFlipper(this, reactNativeHost.reactInstanceManager)
    }

    private companion object {
        private fun initializeFlipper(context: Context, reactInstanceManager: ReactInstanceManager) {
            if (!BuildConfig.DEBUG) { return }
            try {
                val aClass = Class.forName("com.helloworld.ReactNativeFlipper")
                val anInstance = aClass.newInstance()
                aClass.getMethod("initializeFlipper", Context::class.java, ReactInstanceManager::class.java)
                        .invoke(anInstance, context, reactInstanceManager)
            } catch (e: Exception) {
                when (e) {
                    is ClassNotFoundException,
                    is NoSuchMethodException,
                    is IllegalAccessException,
                    is InvocationTargetException -> {
                        e.printStackTrace()
                    }
                    else -> throw e
                }
            }
        }
    }
}
