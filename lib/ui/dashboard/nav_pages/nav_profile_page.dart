import 'package:ecommerce/domain/constants/app_constants.dart';
import 'package:ecommerce/domain/constants/app_routes.dart';
import 'package:ecommerce/ui/on_boarding/bloc/user_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../on_boarding/bloc/user_bloc.dart';
import '../../on_boarding/bloc/user_state.dart';

class NavProfilePage extends StatefulWidget {
  const NavProfilePage({super.key});

  @override
  State<NavProfilePage> createState() => _NavProfilePageState();
}

class _NavProfilePageState extends State<NavProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(FetchUserDetails());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is UserSuccessState) {
            var user = state.userModel;
            if (user == null) {
              return const Center(child: Text("No user details available"));
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    const CircleAvatar(
                      radius: 40,
                      child: Icon(Icons.person, size: 40),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      user.name.isNotEmpty ? user.name : 'User Profile',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      user.email,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Card(
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.person),
                            title: const Text('Name'),
                            subtitle: Text(user.name),
                          ),
                          const Divider(height: 1),
                          ListTile(
                            leading: const Icon(Icons.email),
                            title: const Text('Email'),
                            subtitle: Text(user.email),
                          ),
                          if (user.mobile_number.isNotEmpty) ...[
                            const Divider(height: 1),
                            ListTile(
                              leading: const Icon(Icons.phone),
                              title: const Text('Mobile Number'),
                              subtitle: Text(user.mobile_number),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 40,),
                    ElevatedButton(
                      onPressed: () async {
                        SharedPreferences pref = await SharedPreferences.getInstance();
                        await pref.remove(AppConstants.PREF_TOKEN_KEY);
                        if (context.mounted) {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRoutes.PAGE_LOGIN,
                            (route) => false,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("Log Out"),
                    )
                  ],
                ),
              ),
            );
          }

          if (state is UserFailureState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.errorMsg,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<UserBloc>().add(FetchUserDetails());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
