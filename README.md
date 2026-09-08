# TrioSuite Invoice ERP

Flutter client for the TrioSuite bilingual sales-invoice application. The app supports authentication, invoice listing and search, invoice creation, invoice details, approval and cancellation, company settings, barcode lookup, and Arabic/English localization.

## Requirements

- Flutter with Dart 3.9 or newer
- Android SDK for Android builds
- The ASP.NET Core API from `triosuite_invoice_erp_api`
- SQL Server initialized with the three scripts in the API project's `Database` directory
- The Android phone and API computer connected to the same local network when using a physical device

Demo login:

```text
Username: admin
Password: Admin@123
```

## Complete local setup

### 1. Prepare SQL Server

Open the API repository and execute these scripts in order:

1. `Database/01_CreateDatabaseAndTables.sql`
2. `Database/02_CreateStoredProcedures.sql`
3. `Database/03_SeedData.sql`

Configure the `SalesInvoiceDB` connection string in the API's `appsettings.json` or through .NET user secrets. Full database instructions are available in the API README.

### 2. Find the API computer's IPv4 address

For a physical Android phone, run this command on the Windows computer that will run the API:

```powershell
ipconfig
```

Read **IPv4 Address** from the active Wi-Fi or Ethernet adapter. Example:

```text
192.168.1.17
```

The IP above is only an example. Do not copy `192.168.1.100`, `192.168.1.17`, or another sample unless it is the actual IPv4 address displayed on the API computer.

### 3. Start the API for network access

From the directory that contains both projects:

```powershell
dotnet run --project .\triosuite_invoice_erp_api\triosuite_invoice_erp_api.csproj --urls "http://0.0.0.0:5112"
```

Or from inside the API project:

```powershell
dotnet run --urls "http://0.0.0.0:5112"
```

Important URL rules:

- `0.0.0.0` is used only by the API to listen on every network interface.
- Never use `0.0.0.0` as the Flutter base URL.
- `localhost` inside Android means the Android device, not the computer.
- `/api/` belongs in `API_BASE_URL`, but not in the API's `--urls` argument.

### 4. Allow Windows Firewall access

Allow the API through Windows Firewall on Private networks when prompted. If required, open PowerShell as Administrator on the API computer and run:

```powershell
New-NetFirewallRule -DisplayName "Triosuite Invoice API 5112" -Direction Inbound -Action Allow -Protocol TCP -LocalPort 5112 -Profile Private
```

### 5. Test from the phone before running Flutter

On the API computer, open:

```text
http://localhost:5112/swagger/index.html
```

On the Android phone, open the same API through the computer's IPv4 address. For example:

```text
http://192.168.1.17:5112/swagger/index.html
```

The phone and computer must be on the same Wi-Fi/router. If Swagger does not open in the phone's browser, fix the network/API issue before testing Flutter.

## Configure `API_BASE_URL`

The app reads the base URL from a Dart compile-time environment value:

```dart
const String.fromEnvironment('API_BASE_URL')
```

The correct value depends on where Flutter runs:

| Flutter target | Correct `API_BASE_URL` |
|---|---|
| Android physical phone | `http://<API-PC-IP>:5112/api/` |
| Android Emulator | `http://10.0.2.2:5112/api/` |
| Windows/Web on the API computer | `http://localhost:5112/api/` |

Keep the `/api/` path in the value. A trailing slash is recommended.

### Run on a physical Android phone

Replace the example IP with the API computer's actual IPv4 address:

```powershell
cd .\triosuite_invoice_erp
flutter pub get
flutter run --dart-define=API_BASE_URL=http://192.168.1.17:5112/api/
```

USB debugging may be used to install/run the application, but API requests still travel over the local network unless `adb reverse` is configured separately.

### Run on an Android Emulator

The standard Android Emulator reaches the host computer through `10.0.2.2`:

```powershell
flutter pub get
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:5112/api/
```

Do not use `10.0.2.2` in an APK intended for a physical Android phone.

### Run on Windows or Web on the API computer

```powershell
flutter pub get
flutter run --dart-define=API_BASE_URL=http://localhost:5112/api/
```

## Build and send an Android Release APK

For a physical phone, build with the actual IPv4 address of the computer that will run the API:

```powershell
flutter clean
flutter pub get
flutter build apk --release --dart-define=API_BASE_URL=http://192.168.1.17:5112/api/
```

The generated APK is located at:

```text
build/app/outputs/flutter-apk/app-release.apk
```

### Important behavior of a prebuilt APK

`API_BASE_URL` is embedded in the application during `flutter build`. It cannot change after installation unless the app provides a runtime server-settings screen.

If you send a prebuilt APK to another person who will run the API and database on their computer:

1. Decide which LAN IP that computer will use, for example `192.168.1.100`.
2. Build the APK using `http://192.168.1.100:5112/api/`.
3. The recipient must configure/reserve that exact IP for their computer.
4. The recipient starts the API with `--urls "http://0.0.0.0:5112"`.
5. The Android phone connects to the same local network.

If the recipient's network uses a different subnet, such as `192.168.0.x` or `10.0.0.x`, the hard-coded address will not work. In that case, rebuild the APK using the recipient's actual IP address. Reserving the address through the router's DHCP settings prevents it from changing later.

## Recipient startup checklist

Every time the recipient wants to use the application:

1. Start the SQL Server service.
2. Confirm that the computer still has the IP embedded in the APK.
3. Start the API:

   ```powershell
   dotnet .\triosuite_invoice_erp_api.dll --urls "http://0.0.0.0:5112"
   ```

   When running from source, use `dotnet run --urls "http://0.0.0.0:5112"` instead.

4. Keep the API process running.
5. Connect the phone to the same local network.
6. Open the app and log in with `admin` / `Admin@123`.

## Troubleshooting Android connectivity

### `Connection refused` or `DioException`

Check these items in order:

1. Verify that SQL Server and the API are running.
2. Confirm that the API console shows port `5112`.
3. Run `ipconfig` and check whether the computer IP changed.
4. Confirm that the APK was built with that exact IP and `/api/`.
5. Open `http://<API-PC-IP>:5112/swagger/index.html` in the phone's browser.
6. Check the Windows Firewall inbound rule for TCP port `5112`.
7. Confirm that both devices use the same non-guest Wi-Fi/router.
8. Disable VPN temporarily and verify that router AP/client isolation is off.

### Swagger opens on the computer but not on the phone

The API is probably listening only on `localhost`, the firewall is blocking the port, or the network prevents device-to-device traffic. Stop the API and restart it with:

```powershell
dotnet run --urls "http://0.0.0.0:5112"
```

### The login request returns a server/database error

Network access is working, but the API cannot reach SQL Server. Check the API connection string, start SQL Server, and run all three database scripts in order.

### The IP address changes after restarting the router

Reserve the computer's address in the router's DHCP settings or rebuild the APK with the new address. A previously built APK continues using the old compile-time value.

## Verification

```powershell
flutter analyze
flutter test
flutter build apk --debug --dart-define=API_BASE_URL=http://10.0.2.2:5112/api/
```

The generated debug APK is located at:

```text
build/app/outputs/flutter-apk/app-debug.apk
```

## Project structure

Features follow the same flow used by authentication:

```text
features/<feature>/
  data/models
  data/repo
  domain/entities
  domain/repo
  presentation/cubit
  presentation/widgets
```

Protected API requests receive the stored JWT automatically. Invoice totals are previewed in Flutter and calculated authoritatively again by the SQL stored procedure when the invoice is saved.
