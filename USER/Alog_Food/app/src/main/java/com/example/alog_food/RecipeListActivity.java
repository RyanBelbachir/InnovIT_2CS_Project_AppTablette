package com.example.alog_food;
import androidx.appcompat.app.AppCompatActivity;
import android.os.Bundle;
import android.provider.SyncStateContract;
import android.util.Log;
import android.view.View;

import com.example.alog_food.models.Recipe;
import com.example.alog_food.requests.RecipeApi;
import com.example.alog_food.requests.ServiceGenerator;
import com.example.alog_food.requests.responses.RecipeSearchResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class RecipeListActivity extends BaseActivity {
    private static final String TAG = "RecipeListActivity";
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        findViewById(R.id.test).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                /*if(mProgressBar.getVisibility() == View.VISIBLE){
                    showProgressBar(false);
                }
                else{
                    showProgressBar(true);
                }*/

                testRetrofitRequest();
            }
        });
    }

    private void testRetrofitRequest(){
        RecipeApi recipeApi = ServiceGenerator.getRecipeApi();

        Call<RecipeSearchResponse> responseCall =  recipeApi.getRecipies("pizza");
        Log.d(TAG,"onResponse: "+responseCall.toString());
        responseCall.enqueue(new Callback<RecipeSearchResponse>(){
            @Override
            public void onResponse(Call<RecipeSearchResponse> call, Response<RecipeSearchResponse> response){
                Log.d(TAG,"OnResponse: "+ response.body().toString());
                if (response.code() == 200){
                    Log.d(TAG,"onResponse: "+response.body().toString());
                    List<Recipe> recipes = new ArrayList<>(response.body().getRecipes());
                    for(Recipe recipe : recipes){
                        Log.d(TAG,"Onresponse: "+recipe.getTitle());
                    }
                }
                else {
                    try{
                        Log.d(TAG,"onResponse "+ response.errorBody().string());
                    }
                    catch (IOException e){
                        e.printStackTrace();
                    }
                }
            }
            @Override
            public void onFailure(Call<RecipeSearchResponse>call,Throwable t){

            }
                             }
                );

    }
}