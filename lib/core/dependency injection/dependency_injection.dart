import 'package:crm_mobile_app/config/dio_client/dio_client.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/repositories/deal_repository.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/repositories/deal_repository_impl.dart';
import 'package:crm_mobile_app/modules/crm/deal/data/services/deal_api.dart';
import 'package:crm_mobile_app/modules/crm/deal/domain/usecase/create_deal_note_usecase.dart';
import 'package:crm_mobile_app/modules/crm/deal/domain/usecase/create_deal_tag_usecase.dart';
import 'package:crm_mobile_app/modules/crm/deal/domain/usecase/create_deal_usecase.dart';
import 'package:crm_mobile_app/modules/crm/deal/domain/usecase/deal_usecase.dart';
import 'package:crm_mobile_app/modules/crm/deal/domain/usecase/delete_deal_usecase.dart';
import 'package:crm_mobile_app/modules/crm/deal/domain/usecase/get_deal_notes_usecase.dart';
import 'package:crm_mobile_app/modules/crm/deal/domain/usecase/search_deal_usecase.dart';
import 'package:crm_mobile_app/modules/crm/deal/domain/usecase/update_deal_status_usecase.dart';
import 'package:crm_mobile_app/modules/crm/deal/presentation/view_model/create_deal_bloc/create_deal_bloc.dart';
import 'package:crm_mobile_app/modules/crm/deal/presentation/view_model/create_deal_note_bloc/create_deal_note_bloc.dart';
import 'package:crm_mobile_app/modules/crm/deal/presentation/view_model/create_deal_tag_bloc/create_deal_tag_bloc.dart';
import 'package:crm_mobile_app/modules/crm/deal/presentation/view_model/deal_bloc/deal_bloc.dart';
import 'package:crm_mobile_app/modules/crm/deal/presentation/view_model/view_deal_notes_bloc/view_deal_notes_bloc.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/repositories/lead_repository.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/repositories/lead_repository_impl.dart';
import 'package:crm_mobile_app/modules/crm/lead/data/services/lead_api.dart';
import 'package:crm_mobile_app/modules/crm/lead/domain/usecase/convert_lead_to_deal_usecase.dart';
import 'package:crm_mobile_app/modules/crm/lead/domain/usecase/create_lead_usecase.dart';
import 'package:crm_mobile_app/modules/crm/lead/domain/usecase/create_note_usecase.dart';
import 'package:crm_mobile_app/modules/crm/lead/domain/usecase/create_tag_usecase.dart';
import 'package:crm_mobile_app/modules/crm/lead/domain/usecase/delete_lead_usecase.dart';
import 'package:crm_mobile_app/modules/crm/lead/domain/usecase/get_notes_usecase.dart';
import 'package:crm_mobile_app/modules/crm/lead/domain/usecase/lead_usecase.dart';
import 'package:crm_mobile_app/modules/crm/lead/domain/usecase/search_lead_usecase.dart';
import 'package:crm_mobile_app/modules/crm/lead/domain/usecase/update_lead_status_usecase.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view_model/convert_to_deal_bloc/convert_to_deal_bloc.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view_model/create_lead_bloc/create_lead_bloc.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view_model/create_note_bloc/create_note_bloc.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view_model/create_tag_bloc/create_tag_bloc.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view_model/dropdown_bloc/dropdown_bloc.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view_model/lead_bloc/lead_bloc.dart';
import 'package:crm_mobile_app/modules/crm/lead/presentation/view_model/view_notes_bloc/view_notes_bloc.dart';
import 'package:crm_mobile_app/modules/dashboard/presentation/view_model/bottom_bar_bloc/bottom_nav_bar_bloc.dart';
import 'package:crm_mobile_app/modules/login/data/repositories/login_repository.dart';
import 'package:crm_mobile_app/modules/login/data/repositories/login_repository_impl.dart';
import 'package:crm_mobile_app/modules/login/data/services/login_api.dart';
import 'package:crm_mobile_app/modules/login/domain/usecase/login_usecase.dart';
import 'package:crm_mobile_app/modules/login/presentation/view_model/login_bloc/login_bloc.dart';
import 'package:get_it/get_it.dart';

//Example of different types of registration in GetIt
// registerSingleton<T>()
// Registers a single instance of a class that is always the same.
// Best for services like API clients or databases.

//getIt.registerSingleton<Dio>(Dio());

// registerLazySingleton<T>()
// Registers a singleton only when it's first needed.
// Saves memory by delaying initialization.
// Best for services that are not always needed.

//getIt.registerLazySingleton<LoginApi>(() => LoginApi(getIt<Dio>()));

// registerFactory<T>()
// Creates a new instance every time it’s requested.
// Best for BLoCs, where each screen needs a fresh instance.

//getIt.registerFactory<LoginBloc>(() => LoginBloc(getIt<LoginUseCase>()));

// registerSingletonWithDependencies<T>()
// Creates a singleton after ensuring its dependencies are ready.
// Best for services that depend on other services.

// getIt.registerSingletonWithDependencies<LoginRepositoryImpl>(
//   () => LoginRepositoryImpl(getIt<LoginApi>()),
//   dependsOn: [LoginApi],
// );

// registerFactoryAsync<T>()
// Registers a factory that returns a Future, useful for async initialization.

// getIt.registerFactoryAsync<Dio>(() async {
//   final dio = Dio();
//   // Perform async setup if needed
//   return dio;
// });

final locator = GetIt.instance;

void init() {
//Common Module Dependencies
  locator.registerLazySingleton<DioClient>(() => DioClient());

// Login Module Dependencies
//API Services
  locator.registerLazySingleton<LoginAPi>(() => LoginAPiImpl(locator()));
//Repositories
  locator.registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(locator()));
//Use Cases
  locator.registerLazySingleton<LoginUsecase>(() => LoginUsecase(locator()));
//Bloc or ViewModels
  locator.registerFactory<LoginBloc>(() => LoginBloc(locator()));

// Dashboard Module Dependencies
//API Services
//Repositories
//UseCaase
//Bloc or ViewModel
  locator.registerFactory<BottomNavBloc>(() => BottomNavBloc());

  // CRM Module Dependencies
  // Lead
  //API Services
  locator.registerLazySingleton<LeadApi>(() => LeadApiImpl(locator()));
//Repositories
  locator.registerLazySingleton<LeadRepository>(
      () => LeadRepositoryImpl(locator()));
// Lead Use Cases
  locator.registerLazySingleton<LeadUsecase>(() => LeadUsecase(locator()));
//Convert To Lead Use Cases
  locator.registerLazySingleton<ConvertLeadToDealUsecase>(
      () => ConvertLeadToDealUsecase(locator()));
//Update Lead Status Usecase
  locator.registerLazySingleton<UpdateLeadStatusUsecase>(
      () => UpdateLeadStatusUsecase(locator()));
//SearchLeadUsecase
  locator.registerLazySingleton<SearchLeadUsecase>(
      () => SearchLeadUsecase(locator()));
//DeleteLeadUsecase
  locator.registerLazySingleton<DeleteLeadUsecase>(
      () => DeleteLeadUsecase(locator()));
//Bloc or ViewModels
  locator.registerFactory<LeadBloc>(
      () => LeadBloc(locator(), locator(), locator(), locator(), locator()));
//Dropdown Bloc
  locator.registerFactory<DropdownBloc>(() => DropdownBloc());
//Bloc or ViewModels
  locator.registerFactory<ConvertLeadToDealBloc>(
      () => ConvertLeadToDealBloc(locator()));
//DeleteLeadUsecase
  locator.registerLazySingleton<CreateLeadUsecase>(
      () => CreateLeadUsecase(locator()));
//Create Tag Usecase
  locator.registerLazySingleton<CreateTagUsecase>(
      () => CreateTagUsecase(locator()));
//Create Lead Bloc
  locator
      .registerFactory<CreateLeadFormBloc>(() => CreateLeadFormBloc(locator()));
  //Create Tag Usecase
  locator.registerLazySingleton<CreateNoteUsecase>(
      () => CreateNoteUsecase(locator()));
  //Get Notes Usecase
  locator
      .registerLazySingleton<GetNotesUsecase>(() => GetNotesUsecase(locator()));
//Create Nte Bloc
  locator.registerFactory<CreateNoteBloc>(() => CreateNoteBloc(locator()));
  //Get Notes Bloc
  locator.registerFactory<GetNotesBloc>(() => GetNotesBloc(locator()));
//Create Tag Bloc
  locator.registerFactory<CreateTagBloc>(() => CreateTagBloc(locator()));



  //API Services
  locator.registerLazySingleton<DealApi>(() => DealApiImpl(locator()));
//Repositories
  locator.registerLazySingleton<DealRepository>(
      () => DealRepositoryImpl(locator()));
//Update Lead Status Usecase
  locator.registerLazySingleton<UpdateDealStatusUsecase>(
      () => UpdateDealStatusUsecase(locator()));
//SearchLeadUsecase
  locator.registerLazySingleton<SearchDealUsecase>(
      () => SearchDealUsecase(locator()));
//DeleteLeadUsecase
  locator.registerLazySingleton<DeleteDealUsecase>(
      () => DeleteDealUsecase(locator()));
//DeleteLeadUsecase
  locator.registerLazySingleton<CreateDealUsecase>(
      () => CreateDealUsecase(locator()));
// Deal Use Cases
  locator.registerLazySingleton<DealUsecase>(() => DealUsecase(locator()));
  // Get Notes Use Cases
  locator.registerLazySingleton<GetDealNotesUsecase>(() => GetDealNotesUsecase(locator()));
    //Get Deal Notes Bloc
  locator
      .registerFactory<GetDealNotesBloc>(() => GetDealNotesBloc(locator()));
  //Get Deals  Bloc
  locator.registerFactory<DealBloc>(
      () => DealBloc(locator(), locator(), locator(), locator()));
      //DeleteLeadUsecase
  locator.registerLazySingleton<CreateDealNoteUsecase>(
      () => CreateDealNoteUsecase(locator()));
  //Create Deal Note Bloc
  locator.registerFactory<CreateDealNoteBloc>(() => CreateDealNoteBloc(locator()));
  //Create Deal Bloc
  locator.registerFactory<CreateDealFormBloc>(() => CreateDealFormBloc(locator()));
   // Get Notes Use Cases
  locator.registerLazySingleton<CreateDealTagUsecase>(
      () => CreateDealTagUsecase(locator()));
  //Get Deal Notes Bloc
  locator.registerFactory<CreateDealTagBloc>(() => CreateDealTagBloc(locator()));
}
