part of 'settings_cubit.dart';

@immutable
sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}

final class SettingsLoading extends SettingsState {}

class SettingsReady extends SettingsState {
  SettingsReady(this.settings, this.currencies);
  final CompanySettingsEntity settings;
  final List<SettingsCurrencyEntity> currencies;
}

final class SettingsSaving extends SettingsReady {
  SettingsSaving(super.settings, super.currencies);
}

final class SettingsSaved extends SettingsReady {
  SettingsSaved(super.settings, super.currencies);
}

final class SettingsLoadFailure extends SettingsState {
  SettingsLoadFailure(this.failure);
  final Failure failure;
}

final class SettingsSaveFailure extends SettingsReady {
  SettingsSaveFailure(this.failure, super.settings, super.currencies);
  final Failure failure;
}
