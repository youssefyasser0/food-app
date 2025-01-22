import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/business_logic/food_app_cubit.dart';
import 'package:food_app/constants/colors.dart';
import 'package:food_app/data/models/categories_model.dart';
import 'package:food_app/data/models/menu_model.dart';
import 'package:food_app/data/repositories/map_repo.dart';
import 'package:food_app/data/repositories/offers_list_repo.dart';
import 'package:food_app/presentation/pages/cart_shopping_screen.dart';
import 'package:food_app/presentation/pages/food_screen.dart';
import 'package:food_app/presentation/pages/wish_screen.dart';
import 'package:food_app/presentation/widgets/custom_form.dart';
import 'package:food_app/presentation/widgets/custom_text.dart';
import 'package:food_app/presentation/widgets/home_compo/categories_compo.dart';
import 'package:food_app/presentation/widgets/home_compo/client_location.dart';
import 'package:food_app/presentation/widgets/home_compo/custom_ads_view.dart';
import 'package:food_app/presentation/widgets/home_compo/custom_drawer.dart';
import 'package:food_app/presentation/widgets/home_compo/custom_icon.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../data/models/ads_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Position? userPlace;
  MapRepo mapRepo = MapRepo();
  StreamSubscription<ServiceStatus>? serviceStatusSubscription;
  List<Placemark>? yourCountry;
  List<Categories> storageCategories = [];
  List<MenuModel> allMenu = [];
  List<MenuModel> categoryFilter = [];
  List<MenuModel> filteredMenu = [];
  List<MenuModel> filteredSearch = [];
  List<OffersModel> displayOffer = [];
  int numberOfIndex = 0;
  PageController pageController = PageController();
  late Timer _adsTimer;
  String? fetchTheUserName = "";
  TextEditingController? searchControl = TextEditingController();

  // open the seatch bar
  openSearchBar(BuildContext context, double heightOfScreen) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: secondButtonColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            15.0,
            15.0,
            15.0,
            MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 15),
              CustomFormField(
                hintText: "Search",
                obscureText: false,
                controller: searchControl,
                onChange: createSearchBar,
              ),

              if(filteredSearch.isNotEmpty)
                 SizedBox(
                   height: heightOfScreen * 0.3,
                   child: ListView.builder(
                       itemCount: filteredSearch.length
                       ,itemBuilder: (context , index) {
                     return InkWell(
                       onTap: () {
                         Navigator.of(context).push(MaterialPageRoute(
                             builder: (context) =>  FoodScreen(orderFood: filteredMenu[index],)));
                       },
                       child: Padding(
                         padding: const EdgeInsets.only(top: 10.0),
                         child: Container(
                           height: 100,
                           width: heightOfScreen,
                           decoration: BoxDecoration(
                               color: iconsBackgroundColor,
                               borderRadius: BorderRadius.circular(15)
                           ),
                           child: Center(
                             child: ListTile(
                               contentPadding: const EdgeInsets.all(8.0),
                               title: CustomText(title: filteredSearch[index].name.toString() , fontSize: 20,
                                 fontWeight: FontWeight.w700,color: backgroundColor,),
                               leading: Image.asset(filteredSearch[index].image.toString() , height: 220,width: 120,
                                 fit: BoxFit.cover,alignment: Alignment.center,),
                             ),
                           ),
                         ),
                       ),
                     );
                   }),
                 )

            ],
          ),
        );
      },
    );
  }

  // get user location
  Future<void> locationSeries() async{
    var blockScreen = BlocProvider.of<FoodAppCubit>(context);

     blockScreen.serviceChange();


  }

  // filter the menu to take what you want
  pressOnCategory(int index) {
    setState(() {
        numberOfIndex = index;
        filteredMenu = allMenu.where((food) {
          return food.fromCategory == storageCategories[index].strCategory;
        }).toList();
    });
  }

  // get the userName
  Future<String?> getTheUserName() async{
    fetchTheUserName = await BlocProvider.of<FoodAppCubit>(context).getTheUserName();
    return fetchTheUserName;
  }

  //filter the menu so you can search
  void createSearchBar(String value) {

    if(value.isNotEmpty){
      setState(() {

        filteredSearch = filteredMenu.where((food){
          final name = food.name ?? '';
          return name.toLowerCase().startsWith(value.toLowerCase());
        }).toList();
        print(filteredSearch.map((item) => item.name).toList());
        print(value);

      });
    }



  }



  Widget changeCategory(List<Categories> filter) {

    if(filter.isEmpty){
      return Padding(
        padding: const EdgeInsets.only(top: 20.0, bottom: 5, left: 20),
        child: CustomText(
          title: "All Menu",
          fontSize: 36, fontWeight: FontWeight.bold,),
      );
    }


    if(numberOfIndex >= 0 && numberOfIndex < filter.length) {
      return Padding(
        padding: const EdgeInsets.only(top: 20.0, bottom: 5, left: 20),
        child: CustomText(
          title: filter[numberOfIndex].strCategory.toString(),
          fontSize: 36, fontWeight: FontWeight.bold,),
      );
    }
     else{
      return Padding(
        padding: const EdgeInsets.only(top: 20.0, bottom: 5, left: 20),
        child: CustomText(
          title: "All Menu",
          fontSize: 36, fontWeight: FontWeight.bold,),
      );
    }
  }

@override
  void initState() {
    filteredSearch = filteredMenu;
      locationSeries();
      BlocProvider.of<FoodAppCubit>(context).getCategories();
      BlocProvider.of<FoodAppCubit>(context).getListOfFood();
      displayOffer = offers;
      _adsTimer = Timer.periodic(const Duration(seconds: 3), (timer){
        if(pageController.hasClients){
          int nextPage = (pageController.page?.toInt() ?? 0) + 1;
          if (nextPage >= displayOffer.length) nextPage = 0;
          pageController.animateToPage(
            nextPage,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      });

      getTheUserName();

    super.initState();
  }

  @override
  void dispose() {
    // Cancel the stream subscription if it's no longer needed
    serviceStatusSubscription?.cancel();
    _adsTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundColor,
      drawer: Drawer(
        backgroundColor: iconsBackgroundColor,
        child: CustomDrawer(
          navigateToWishList: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => WishScreen())),
          navigateToLogin: () => BlocProvider.of<FoodAppCubit>(context).signOut(),
          title: fetchTheUserName.toString(),
          navigateToCartShopping: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const CartShoppingScreen())),
        ),

      ),
      body: BlocBuilder<FoodAppCubit ,FoodAppState>(
        builder: (BuildContext context, FoodAppState state) {

          if(state is GetUserLocation && state.userPlace != null){
              userPlace = (state).userPlace;
          }

          if(state is YourCountry){
            yourCountry = state.yourCountryLocation;
          }

          if(state is FoodCategoriesIsFetching){
            if(state.allFoodCategories.isNotEmpty){
              storageCategories = state.allFoodCategories;
            }
          }

          if(state is FetchTheMenu){
            if(state.menu.isNotEmpty){
              allMenu = (state).menu;
              filteredMenu = allMenu;
            }else{
              print("in home page list is empty");
            }
          }


          // filter categories list
          List<Categories> filterList = storageCategories.where((category){
            return category.idCategory != "13" && category.idCategory != "14";
          }).toList();

         return ListView(
          children: [
           // head of screen
            Padding(
                  padding: const EdgeInsets.only(top: 15.0 , right: 15.0 , left: 15.0 , bottom: 45.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // drawer icon
                        InkWell(
                          onTap: (){
                              // to be able to open drawer by press on it
                            Scaffold.of(context).openDrawer();
                          },
                            child: const CustomIcon(icon: Icons.menu,)),

                      // client location

                      if(yourCountry != null) ClientLocation(title: "${yourCountry![0].isoCountryCode} "
                            ", ${yourCountry![0].administrativeArea}",pressOnArrow: () async{
                      },)

                      else if(yourCountry == null) ClientLocation(title: "--"", --" , pressOnArrow: ()async{
                        var blockScreen = BlocProvider.of<FoodAppCubit>(context);

                        await blockScreen.getUserLocation();

                        await blockScreen.userCountryLocation();
                      },),

                      // search bar
                      InkWell(
                        onTap: () => openSearchBar(context , screenHeight),
                        child: const Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: CustomIcon(icon: Icons.search,),
                        ),
                      ),
                    ],
                  ),
                ) ,


              // ADS
            Align(
              alignment: Alignment.center,
              child: Container(
                constraints: const BoxConstraints(
                  maxHeight: 220 ,
                  minHeight: 190
                ),
                width: screenWidth * 0.8,
                height: 200,
                decoration:  BoxDecoration(
                    color: iconsBackgroundColor,
                    borderRadius: BorderRadius.circular(15),
                ),

                child: PageView.builder(
                    controller: pageController,
                    itemCount: displayOffer.length,
                    itemBuilder: (context , index){
                  return CustomAdsView(adImage: displayOffer[index].image.toString(),
                      adContent: displayOffer[index].content.toString(),
                      );
                }),
              ),
            ),



              // text of CATEGORIES
            const Padding(
              padding: EdgeInsets.only(top: 20.0 , bottom: 5 , left: 20),
              child: CustomText(title: "Categories" , fontSize: 36, fontWeight: FontWeight.bold,),
            ),



              // the categories to choose
            FoodCategories(
              height: screenHeight * 0.3,
                widget: Padding(
                  padding: const EdgeInsets.only(top: 15.0, left: 25.0 , right: 25.0 , bottom: 15.0),
                  child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisSpacing: 30 , crossAxisCount: 2 , mainAxisSpacing: 30),
                      scrollDirection: Axis.horizontal,
                      itemCount: filterList.length  ,
                      itemBuilder: (context , index){
                        return InkWell(
                          onTap:() {
                            changeCategory(filterList);
                            pressOnCategory(index);
                            },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10.0 , top: 10.0 , right: 4 ,left: 4),
                            child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: iconsBackgroundColor,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black38,
                                      offset: Offset(4, 2),
                                      blurRadius: 5.5
                                    )
                                  ]
                                ),
                              child: Image.network(storageCategories[index].strCategoryThumb.toString() ,
                                    loadingBuilder: (context , child,loadingProgress){
                                        if(loadingProgress == null) return child;
                                        return const Center(
                                          child: CircularProgressIndicator(

                                          ),
                                        );
                                    },
                              ),
                            ),
                          ),
                        );
                      }),
                ),
            ),

              // the category you choose
            changeCategory(filterList),

             // the menu
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: List.generate(filteredMenu.length, (index){
               return InkWell(
                 onTap: () {
                   Navigator.of(context).push(MaterialPageRoute(
                       builder: (context) =>  FoodScreen(orderFood: filteredMenu[index],)));
                 },
                 child: Padding(
                   padding: const EdgeInsets.only(top: 8.0 , bottom: 8.0 , left: 20.0 , right: 20.0),
                   child: SingleChildScrollView(
                     child: Column(
                       children: [
                         Container(
                           height: 100,
                           width: screenWidth,
                            decoration: BoxDecoration(
                              color: iconsBackgroundColor,
                              borderRadius: BorderRadius.circular(15)
                            ),
                           child: Center(
                             child: ListTile(
                               subtitle: CustomText(title: "\$${filteredMenu[index].price}" ,
                                 fontSize: 16,fontWeight: FontWeight.bold,),
                                 contentPadding: const EdgeInsets.all(8.0),
                               title: CustomText(title: filteredMenu[index].name.toString() , fontSize: 20,
                                 fontWeight: FontWeight.w700,color: backgroundColor,),
                               leading: Image.asset(filteredMenu[index].image.toString() , height: 220,width: 120,
                                 fit: BoxFit.cover,alignment: Alignment.center,),
                             ),
                           ),
                         ),
                       ],
                     ),
                   ),
                 ),
               );
             }),
           )

          ],
                 );
        },
      ),
    );
  }
}
