import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triosuite_invoice_erp/core/errors/failures.dart';
import 'package:triosuite_invoice_erp/features/settings/domain/entities/company_settings_entity.dart';
import 'package:triosuite_invoice_erp/features/settings/domain/repo/settings_repo.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({required this.settingsRepo}) : super(SettingsInitial());

  final SettingsRepo settingsRepo;

  Future<void> load() async {
    emit(SettingsLoading());
    final settingsResult = await settingsRepo.getSettings();
    final currenciesResult = await settingsRepo.getCurrencies();

    Failure? failure;
    CompanySettingsEntity? settings;
    List<SettingsCurrencyEntity>? currencies;
    settingsResult.fold(
      (value) => failure = value,
      (value) => settings = value,
    );
    currenciesResult.fold(
      (value) => failure ??= value,
      (value) => currencies = value,
    );

    if (failure != null || settings == null || currencies == null) {
      emit(SettingsLoadFailure(failure ?? Failure('Unable to load settings.')));
      return;
    }
    emit(SettingsReady(settings!, currencies!));
  }

  Future<void> save(CompanySettingsFormEntity form) async {
    final current = state;
    if (current is! SettingsReady) return;
    emit(SettingsSaving(current.settings, current.currencies));
    final result = await settingsRepo.updateSettings(form);
    result.fold(
      (failure) => emit(
        SettingsSaveFailure(failure, current.settings, current.currencies),
      ),
      (settings) => emit(SettingsSaved(settings, current.currencies)),
    );
  }
}
