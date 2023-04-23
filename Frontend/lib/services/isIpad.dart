 // This function determines whether the device is an iPad or not
import 'package:device_info/device_info.dart';

Future<bool> isIpad() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    IosDeviceInfo info = await deviceInfo.iosInfo;

    return info.name.toLowerCase().contains("ipad");
}