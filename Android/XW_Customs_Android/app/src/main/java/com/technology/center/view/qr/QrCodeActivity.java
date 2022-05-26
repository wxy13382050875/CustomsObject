package com.technology.center.view.qr;


import android.os.Bundle;
import android.os.PersistableBundle;
import android.view.KeyEvent;

import androidx.appcompat.app.AppCompatActivity;

import com.journeyapps.barcodescanner.CaptureManager;
import com.journeyapps.barcodescanner.DecoratedBarcodeView;
import com.technology.center.R;
public class QrCodeActivity extends AppCompatActivity implements DecoratedBarcodeView.TorchListener {

        private DecoratedBarcodeView decoratedBarcodeView;
        private CaptureManager captureManager;

        @Override
        protected void onCreate(Bundle savedInstanceState) {
            super.onCreate(savedInstanceState);
            setContentView(R.layout.activity_qr_code);

            decoratedBarcodeView=this.findViewById(R.id.decoratedBarcodeView);
            //重要代码，初始化捕获
            captureManager = new CaptureManager(this, decoratedBarcodeView);
            captureManager.initializeFromIntent(getIntent(), savedInstanceState);
            captureManager.decode();
            decoratedBarcodeView.setTorchListener(this);
        }

        @Override
        public void onTorchOn() {

        }

        @Override
        public void onTorchOff() {

        }

        @Override
        protected void onPause() {
            super.onPause();
            captureManager.onPause();
        }

        @Override
        protected void onResume() {
            super.onResume();
            captureManager.onResume();
        }

        @Override
        protected void onDestroy() {
            super.onDestroy();
            captureManager.onDestroy();
        }

        @Override
        public void onSaveInstanceState(Bundle outState, PersistableBundle outPersistentState) {
            super.onSaveInstanceState(outState, outPersistentState);
            captureManager.onSaveInstanceState(outState);
        }

        @Override
        public boolean onKeyDown(int keyCode, KeyEvent event) {
            return decoratedBarcodeView.onKeyDown(keyCode, event) || super.onKeyDown(keyCode, event);
        }


}