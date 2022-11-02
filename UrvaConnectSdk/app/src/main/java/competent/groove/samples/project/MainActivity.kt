package competent.groove.samples.project

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import com.enefce.samples.androidlibdemo.R
import competent.groove.urvachat.model.UrvaConnectConfig
import competent.groove.urvaconnect.sdk.UrvaChat

//import competent.groove.urvaconnect.sdk.UrvaChat

//import competent.groove.urvaconnect.sdk.UrvaChat
//import competent.groove.urvaconnect.sdk.UrvaChat
//import com.enefce.libraries.sampleandroidlib.SampleAndroidLibMain

//import github.tobsef.demo.HelloMaven;



class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

       // UrvaConnectConfig

        var urvachat = UrvaChat(this);
     //   urvachat.init();


        //Initialise the main class from the Sample Android Library module
//        val sampleAndroidLibMain = SampleAndroidLibMain()
//        tv_welcome.text = sampleAndroidLibMain.welcomeString
    }
}
