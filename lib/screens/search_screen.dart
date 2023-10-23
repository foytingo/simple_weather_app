import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> searchHistory = [];

  @override
  void initState() {
    super.initState();
    loadSearchHistory();
  }

  void _clearTextField() {
    _searchController.clear();
    FocusScopeNode currentFocus = FocusScope.of(context);
    setState(() {
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
    });
  }

  Future<void> loadSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> items = prefs.getStringList('items') ?? [];
    setState(() {
      searchHistory = items;
    });

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        currentFocus.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.amber,size: 30),
          title: const Text("Search Location"),
        ),
    
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
          child: Column(
             mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _searchController,
                textInputAction: TextInputAction.search,
                        
                onChanged: (value) {
                  setState(() {});
                },
                onSubmitted: (searchText) {
                  Navigator.pop(context, searchText);
                },
              
                decoration: InputDecoration(
                  isDense: true,
                  hintText: "Search by city name...",
                  suffixIcon: _searchController.text.isNotEmpty ? IconButton(onPressed: _clearTextField, icon: const Icon(Icons.clear)) : null,
                  prefixIcon: const Icon(Icons.search),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(width: 1, color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(width: 1, color: Colors.amber),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text("Recently searched cities", style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey),),
    
              Expanded(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: searchHistory.length,
                  itemBuilder: (context,index) {
                    return ListTile(
                      title: Text(searchHistory[index]),
                      leading: const Icon(Icons.location_on),
                      trailing: const Icon(Icons.chevron_right, color: Colors.amber,),
                      onTap: () { 
                        Navigator.pop(context, searchHistory[index]);
                       }
                    );
                }),
              )
            ],
          ),
        ),
    
      ),
    );
  }
}