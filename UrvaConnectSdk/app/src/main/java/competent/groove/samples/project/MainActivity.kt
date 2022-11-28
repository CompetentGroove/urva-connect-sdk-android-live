package competent.groove.samples.project

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

//        EditText email = findViewById(R.id.edit_text);
//        Button validate = findViewById(R.id.button);
//        validate.setOnClickListener(v -> {
//            if (EmailValidate.getInstance().isValid(String.valueOf(email.getText())))
//                Toast.makeText(MainActivity.this, getString(R.string.valid), Toast.LENGTH_SHORT).show();
//            else
//                Toast.makeText(MainActivity.this, getString(R.string.invalid), Toast.LENGTH_SHORT).show();
//        });
    }
}