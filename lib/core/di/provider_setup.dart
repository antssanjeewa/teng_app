import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/datasources/local/data_provider.dart';
import '../../data/datasources/remote/firebase_auth_service.dart';

// import '../../data/repositories/user_repository_impl.dart';
import '../../data/datasources/remote/firestore_service.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../../data/repositories/job_repository_impl.dart';
import '../../data/repositories/location_repository_impl.dart';
import '../../domain/repositories/home_repository.dart';
import '../../domain/repositories/job_repository.dart';
import '../../domain/repositories/location_repository.dart';
// import '../../domain/repositories/user_repository.dart';
import '../../domain/repositories/auth_repository.dart';
// import '../../domain/usecases/get_user_usecase.dart';

import '../../presentation/features/auth/viewModels/login_view_model.dart';
import '../../presentation/features/locations/viewmodels/location_create_view_modal.dart';
import '../../presentation/features/locations/viewmodels/location_list_viewmodel.dart';
import '../../presentation/features/jobs/viewmodel/job_create_viewmodel.dart';

class ProviderSetup {
  ProviderSetup._();

  static List<SingleChildWidget> get providers => [
    /// --------------------------------
    /// Firebase Core SDK Instances
    /// --------------------------------
    Provider<FirebaseAuth>(create: (_) => FirebaseAuth.instance),
    Provider<FirebaseFirestore>(create: (_) => FirebaseFirestore.instance),

    /// --------------------------------
    /// Firebase Service Wrappers
    /// --------------------------------
    ChangeNotifierProvider<AuthService>(create: (context) => AuthService()),
    ChangeNotifierProxyProvider<AuthService, DataProvider>(
      create: (_) => DataProvider(),
      update: (context, auth, data) {
        if (auth.isAuthenticated && data != null && !data.isInitialized) {
          data.initializeData();
        }
        return data!;
      },
    ),

    Provider<FirestoreService>(
      create: (context) =>
          FirestoreService(firestore: context.read<FirebaseFirestore>()),
    ),

    /// --------------------------------
    /// Repositories
    /// --------------------------------
    Provider<AuthRepository>(create: (context) => AuthRepositoryImpl()),

    Provider<LocationRepository>(
      create: (context) => LocationRepositoryImpl(
        firestoreService: context.read<FirestoreService>(),
        dataProvider: context.read<DataProvider>(),
      ),
    ),

    Provider<JobRepository>(
      create: (context) => JobRepositoryImpl(
        firestoreService: context.read<FirestoreService>(),
        dataProvider: context.read<DataProvider>(),
      ),
    ),

    Provider<HomeRepository>(
      create: (context) =>
          HomeRepositoryImpl(dataProvider: context.read<DataProvider>()),
    ),

    // Provider<UserRepository>(create: (context) => UserRepositoryImpl()),

    /// --------------------------------
    /// Use Cases
    /// --------------------------------
    // Provider<GetUserUseCase>(
    //   create: (context) => GetUserUseCase(context.read<UserRepository>()),
    // ),

    /// --------------------------------
    /// ViewModels
    /// --------------------------------
    ChangeNotifierProvider<LoginViewModel>(
      create: (context) =>
          LoginViewModel(authRepository: context.read<AuthRepository>()),
    ),

    ChangeNotifierProvider<LocationCreateViewModel>(
      create: (context) => LocationCreateViewModel(
        repository: context.read<LocationRepository>(),
      ),
    ),

    ChangeNotifierProvider<LocationListViewModel>(
      create: (context) =>
          LocationListViewModel(repository: context.read<LocationRepository>()),
    ),

    ChangeNotifierProvider<JobCreateViewModel>(
      create: (context) =>
          JobCreateViewModel(repository: context.read<JobRepository>()),
    ),
  ];
}
