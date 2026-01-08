import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// import '../../data/datasources/remote/firebase/firebase_auth_service.dart';
// import '../../data/datasources/remote/firebase/firestore_service.dart';

// import '../../data/repositories/user_repository_impl.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/usecases/get_user_usecase.dart';

// import '../../presentation/features/auth/viewmodels/login_viewmodel.dart';

class ProviderSetup {
  ProviderSetup._();

  static List<SingleChildWidget> get providers => [
    /// --------------------------------
    /// Firebase Core SDK Instances
    /// --------------------------------
    // Provider<FirebaseAuth>(create: (_) => FirebaseAuth.instance),

    // Provider<FirebaseFirestore>(create: (_) => FirebaseFirestore.instance),

    /// --------------------------------
    /// Firebase Service Wrappers
    /// --------------------------------
    // Provider<FirebaseAuthService>(
    //   create: (context) => FirebaseAuthService(context.read<FirebaseAuth>()),
    // ),

    // Provider<FirestoreService>(
    //   create: (context) => FirestoreService(context.read<FirebaseFirestore>()),
    // ),

    /// --------------------------------
    /// Repositories
    /// --------------------------------
    // Provider<UserRepository>(
    //   create: (context) => UserRepositoryImpl(
    //     authService: context.read<FirebaseAuthService>(),
    //     firestoreService: context.read<FirestoreService>(),
    //   ),
    // ),

    /// --------------------------------
    /// Use Cases
    /// --------------------------------
    Provider<GetUserUseCase>(
      create: (context) => GetUserUseCase(context.read<UserRepository>()),
    ),

    /// --------------------------------
    /// ViewModels
    /// --------------------------------
    // ChangeNotifierProvider<LoginViewModel>(
    //   create: (context) => LoginViewModel(context.read<GetUserUseCase>()),
    // ),
  ];
}
