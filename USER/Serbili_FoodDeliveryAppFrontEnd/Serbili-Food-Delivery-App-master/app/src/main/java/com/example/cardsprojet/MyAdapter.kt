package com.example.cardsprojet

import android.annotation.SuppressLint
import android.content.ActivityNotFoundException
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.view.LayoutInflater
import android.view.ViewGroup
import android.widget.ProgressBar
import androidx.recyclerview.widget.RecyclerView
import com.example.cardsprojet.databinding.LayoutRestoListItemBinding
import com.example.cardsprojet.models.Restaurant

class MyAdapter(val data: List<Restaurant>):RecyclerView.Adapter<MyAdapter.MyViewHolder>() {



    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): MyViewHolder {
        return MyViewHolder(LayoutRestoListItemBinding.inflate(LayoutInflater.from(parent.context), parent, false))
    }

    override fun getItemCount() = data.size

    @SuppressLint("RestrictedApi")
    override fun onBindViewHolder(holder: MyViewHolder, position: Int) {


        holder.binding.apply {
            textName.text = data[position].name
            typeFoodId.text = data[position].type_resto.nom
            Rating.rating= data[position].rating.toFloat()
            Adress.text=data[position].location
            logo.setImageResource(R.drawable.resto)

            mapsPhoto.setOnClickListener {
                val latitude = data[position].latitude  // Latitude de la position à afficher
                val longitude =  data[position].longitude // Longitude de la position à afficher
                try {
                    val uri = Uri.parse("geo:$latitude,$longitude?q=$latitude,$longitude")
                    val context = holder.itemView.context
                    val intent = Intent(Intent.ACTION_VIEW, uri)
                    intent.setPackage("com.google.android.apps.maps")
                    context.startActivity(intent)
                } catch (ex: ActivityNotFoundException) {
                    val mapsUrl = "http://maps.google.com/maps?q=$latitude,$longitude"
                    val context = holder.itemView.context
                    val mapsIntent = Intent(Intent.ACTION_VIEW, Uri.parse(mapsUrl))
                    context.startActivity(mapsIntent)

                }
            }

            facebookIcon.setOnClickListener{


                val facebookPackageName = "com.facebook.katana"
                val facebookUrl = "https://www.facebook.com/kamyl.tb"
                val context = holder.itemView.context
                val intent = Intent(Intent.ACTION_VIEW)
                intent.data = Uri.parse("fb://facewebmodal/f?href=$facebookUrl")

                try {
                    // Vérifier si l'application Facebook est installée
                    context.packageManager.getPackageInfo(facebookPackageName, 0)
                    intent.setPackage(facebookPackageName)
                } catch (e: PackageManager.NameNotFoundException) {
                    // Si l'application Facebook n'est pas installée, ouvrir le lien dans le navigateur
                    intent.data = Uri.parse(facebookUrl)
                }

// Lancer l'activité avec l'intent
                context.startActivity(intent)

            }
        }



    }




    class MyViewHolder(val binding: LayoutRestoListItemBinding) : RecyclerView.ViewHolder(binding.root)

}



