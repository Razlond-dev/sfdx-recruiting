trigger JobApplicationTrigger on Job_Application__c(after update) {
  if (Trigger.isAfter && Trigger.isUpdate) {
    JobApplicationTriggerHandler.afterUpdate(Trigger.new);
    Map<String, Integer> timeZoneWBX = new Map<String, Integer>{
      'Pacific/Fiji' => 61,
      'Pacific/Tongatapu' => 153,
      'Asia/Kamchatka' => 60,
      'Australia/Sydney' => 55,
      'Pacific/Guadalcanal' => 59,
      'Australia/Adelaide' => 52,
      'Australia/Darwin' => 53,
      'Asia/Seoul' => 50,
      'Asia/Tokyo' => 49,
      'Asia/Kuala_Lumpur' => 134,
      'Asia/Singapore' => 47,
      'Asia/Taipei' => 48,
      'Australia/Perth' => 46,
      'Asia/Bangkok' => 44,
      'Asia/Jakarta' => 154,
      'Asia/Yekaterinburg' => 39,
      'Asia/Kathmandu' => 141,
      'Asia/Colombo' => 42,
      'Asia/Kabul' => 38,
      'Asia/Dubai' => 36,
      'Europe/Moscow' => 33,
      'Asia/Yerevan' => 155,
      'Africa/Nairobi' => 34,
      'Asia/Riyadh' => 32,
      'Africa/Cairo' => 28,
      'Europe/Athens' => 26,
      'Europe/Bucharest' => 27,
      'Europe/Helsinki' => 30,
      'Europe/Istanbul' => 140,
      'Africa/Algiers' => 143,
      'Africa/Casablanca' => 136,
      'Europe/Amsterdam' => 22,
      'Europe/Berlin' => 25,
      'Europe/Brussels' => 147,
      'Europe/Paris' => 23,
      'Europe/Prague' => 24,
      'Europe/Rome' => 142,
      'Europe/Dublin' => 163,
      'Europe/Lisbon' => 161,
      'Europe/London' => 21,
      'GMT' => 20,
      'Atlantic/Azores' => 19,
      'Atlantic/Cape_Verde' => 150,
      'America/Argentina/Buenos_Aires' => 17,
      'America/Santiago' => 145,
      'America/Halifax' => 13,
      'America/Caracas' => 133,
      'America/Bogota' => 10,
      'America/Indiana/Indianapolis' => 12,
      'America/New_York' => 11,
      'America/Panama' => 146,
      'America/Chicago' => 7,
      'America/Mexico_City' => 8,
      'America/Denver' => 6,
      'America/Phoenix' => 4,
      'America/Los_Angeles' => 4,
      'America/Tijuana' => 131,
      'America/Anchorage' => 3,
      'Pacific/Honolulu' => 2
    };
  }
}
