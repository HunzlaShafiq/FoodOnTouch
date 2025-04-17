import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/FirebaseDataProviders/ProfileProvider.dart';
import 'package:fooddelivery/LoginAndLogoutServices/LoginAndLogoutServices.dart';
import 'package:fooddelivery/Routes/Routes.dart';
import 'package:fooddelivery/Utils/Components/ErrorToast.dart';
import 'package:fooddelivery/Utils/Contants/Constants.dart';
import 'package:fooddelivery/Utils/Components/FlushMessage.dart';
import 'package:fooddelivery/Utils/Components/MyButton.dart';
import 'package:fooddelivery/Utils/Components/MyNetwokCacheImage.dart';
import 'package:fooddelivery/Utils/Components/ProfileListTiles.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  Widget build(BuildContext context) {


    final String userId= FirebaseAuth.instance.currentUser!.uid;

    final profileValue =Provider.of<ProfileProvider>(context,listen: false
    );


    return Scaffold(
      body:Stack(
        children:[
          Consumer<ProfileProvider>(
              builder: ( context,profileProviderValues,child){

                if(profileProviderValues.isLoading){
                  return const Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        SizedBox(height: 40,),
                        CircleAvatar(
                          backgroundColor: gray3,
                          radius:70 ,
                          child: Icon(Icons.image_outlined,size: 40,),
                        ),

                        SizedBox(height: 10,),

                        Text('Loading',style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold,),),
                        Text("Loading",style: TextStyle(fontSize: 16),),
                        SizedBox(height: 10,),


                      ],
                    ),
                  );
                }
                else{
                  final String userName=profileProviderValues.profileData['userName'];
                  final String userImageUrl=profileProviderValues.profileData['userProfileImage'];
                  final String userEmail=profileProviderValues.profileData['userEmail'];
                  final String userPhoneNumber=profileProviderValues.profileData['userPhoneNo'];
                  final String userAddress=profileProviderValues.profileData['userAddress'];
                  return Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        const SizedBox(height: 40,),
                        CircleAvatar(
                          backgroundColor: gray3,
                          radius:70 ,
                          child:ClipOval(
                            child: userImageUrl==''? const Icon(Icons.person,size: 40,)
                                : MyNetworkCacheImage(imageUrl: userImageUrl, height: 150, width: 160,boxFit: BoxFit.cover,),
                          )
                        ),

                        const SizedBox(height: 10,),

                        Text(userName,style: const TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold,),),
                        Text(userEmail,style: const TextStyle(fontSize: 16),),
                        const SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 10),
                          child: MYButton(

                            actionText: "Edit Profile", onTab: (){
                            Navigator.pushNamed(
                                context,
                                RoutesName.editProfile,
                                arguments: {
                                  'userId':userId,
                                  'userName':userName,
                                  'userImageUrl':userImageUrl,
                                  'userEmail':userEmail,
                                  'userPhoneNumber':userPhoneNumber,
                                  'userAddress':userAddress

                                }
                            );
                          }),
                        )

                      ],
                    ),
                  );
                }

              }
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 430,
              decoration: const BoxDecoration(
                  color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(40),topLeft:Radius.circular(40) )
              ),
              child:  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    const SizedBox(height: 30,),
                    ProfileListTiles(text: "My Details", onTab: (){

                      final String userName=profileValue.profileData['userName'];
                      final String userImageUrl=profileValue.profileData['userProfileImage'];
                      final String userEmail=profileValue.profileData['userEmail'];
                      final String userPhoneNumber=profileValue.profileData['userPhoneNo'];
                      final String userAddress=profileValue.profileData['userAddress'];

                      Navigator.pushNamed(context, RoutesName.myDetails
                      ,arguments: {
                            'userId':userId,
                            'userName':userName,
                            'userImageUrl':userImageUrl,
                            'userEmail':userEmail,
                            'userPhoneNumber':userPhoneNumber,
                            'userAddress':userAddress
                          }
                      );
                    }, icon: Icons.account_box_outlined),
                    const SizedBox(height: 15,),
                    ProfileListTiles(
                        text: 'My Orders',
                        onTab:(){
                          Navigator.pushReplacementNamed(context, RoutesName.myOrders);
                        },
                        icon: Icons.shopping_bag_outlined),
                    const SizedBox(height: 15,),
                    ProfileListTiles(text: "Change Password", onTab: (){
                      final String userEmail=profileValue.profileData['userEmail'];

                      Navigator.pushNamed(context, RoutesName.changePassword,
                      arguments: {
                        'userEmail': userEmail
                      });

                    }, icon: Icons.password),
                    const SizedBox(height: 15,),
                    ProfileListTiles(
                        text: 'LogOut',
                        onTab: (){

                          try{
                            //this handle all signOut events on user Logout
                            LoginAndLogoutServices().userLogOut(context);
                          }
                          catch(e){
                            ErrorToast().errorToastMessage(e.toString());
                          }
                          finally{

                            FirebaseAuth.instance.signOut();


                            Navigator.pushReplacementNamed(context, RoutesName.logIn);
                          }

                    },
                        icon: Icons.logout)

                  ],
                ),
              ),
            ),
          )
        ]
      ),
    );
  }
}
