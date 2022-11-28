package competent.groove.urvaconnect.sdk

import android.content.Context
import android.util.Log
import competent.groove.urvachat.model.UrvaConnectConfig
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodChannel
import org.json.JSONObject

class UrvaChat(context: Context) {
    private var context: Context? = null
    private val ENGINE_ID = "1"

    companion object {
        var config1: UrvaConnectConfig? = null
        private var channel: MethodChannel? = null
        fun getInstance(context: Context): UrvaChat {
            return UrvaChat(context)
        }
        fun showConversations(context: Context) {
            if (config1 != null) {
                val data = getJson(config1!!)
                channel!!.invokeMethod("reportKey", data)
                val intent = FlutterActivity.withCachedEngine("1").build(context)
                context.startActivity(intent)
            }
        }
        private fun getJson(config: UrvaConnectConfig): String? {
            val jsonObject = JSONObject()
            if (config.orgCode == null) {
                jsonObject.put("org", "")
            } else {
                jsonObject.put("org", config.orgCode)
            }

            if (config.username == null) {
                jsonObject.put("uuid", "")
            } else {
                jsonObject.put("uuid", config.username)
            }


            if (config.last_name == null) {
                jsonObject.put("last_name", "")
            } else {
                jsonObject.put("last_name", config.last_name)
            }

            if (config.first_name == null) {
                jsonObject.put("first_name", "")
            } else {
                jsonObject.put("first_name", config.first_name)
            }

            if (config.companyToken == null) {
                jsonObject.put("x-urva-key", "")
            } else {
                jsonObject.put("x-urva-key", config.companyToken)
            }

            if (config.domain == null) {
                jsonObject.put("url", "")
            } else {
                jsonObject.put("url", config.domain)
            }

            if (config.fcmToken == null) {
                jsonObject.put("fcm_token", "")
            } else {
                jsonObject.put("fcm_token", config.fcmToken)
            }

            Log.e("Data", jsonObject.toString())
            return jsonObject.toString()
        }
    }

    init {
        this.context = context.applicationContext
    }
    fun init(config: UrvaConnectConfig) {
        config1 = config
        callMethodChannel()
    }

    private fun callMethodChannel() {
        val flutterEngine = FlutterEngine(context!!)
        flutterEngine.dartExecutor.executeDartEntrypoint(DartExecutor.DartEntrypoint.createDefault())
        FlutterEngineCache.getInstance().put(ENGINE_ID, flutterEngine)
        channel = MethodChannel(flutterEngine.dartExecutor, "competent.groove.convergesdk/sendinfo")
        if (config1 != null) {
            val data = getJson(config1!!)
            channel!!.invokeMethod("reportKey", data)
        }
    }
}




