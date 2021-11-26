// List<User> users = [SELECT TimeZoneSidKey, LocaleSidKey FROM User WHERE Name = 'SH9rutchanee Chayakajorn'];
// //  WBX_Access_Token_Not_Encrypted__c,
// System.debug('timezone: ' + users);
// // Map<String, Integer> timeZoneWBX = new Map<String, Integer>{
// // // 'Pacific/Kiritimati' => 61, +2
// // // 'Pacific/Chatham' => 61, +0.45
// // // 'Pacific/Auckland' => 60, ?
// // // 'Pacific/Enderbury' => 61, +1 
// // 'Pacific/Fiji' => 61,
// // 'Pacific/Tongatapu' => 153, // check 
// // 'Asia/Kamchatka' => 60,
// // // 'Pacific/Norfolk' => 59, ?
// // // 'Australia/Lord_Howe' => 55, ? 
// // 'Australia/Sydney' => 55, 
// // 'Pacific/Guadalcanal' => 59,
// // 'Australia/Adelaide' => 52,
// // 'Australia/Darwin' => 53,
// // 'Asia/Seoul' => 50,
// // 'Asia/Tokyo' => 49,
// // // 'Asia/Hong_Kong' => 48, ?
// // 'Asia/Kuala_Lumpur' => 134, 
// // // 'Asia/Manila' => 48, ?
// // // 'Asia/Shanghai' => 48, ?
// // 'Asia/Singapore' => 47, 
// // 'Asia/Taipei' => 48, 
// // 'Australia/Perth' => 46,
// // 'Asia/Bangkok' => 44,
// // // 'Asia/Ho_Chi_Minh' => 44, ?
// // 'Asia/Jakarta' => 154, 
// // // 'Asia/Rangoon' => 44, ?
// // // 'Asia/Dhaka' => 43, ? 
// // 'Asia/Yekaterinburg' => 39, 
// // 'Asia/Kathmandu' => 141,
// // 'Asia/Colombo' => 42, 
// // // 'Asia/Kolkata' => 41, ?
// // // 'Asia/Karachi' => 39, ?
// // // 'Asia/Tashkent' => 39, ?
// // 'Asia/Kabul' => 38, 
// // 'Asia/Dubai' => 36,
// // // 'Asia/Tbilisi' => 37, ?
// // 'Europe/Moscow' => 33,
// // 'Asia/Yerevan' => 155,
// // 'Asia/Tehran' => 2, // 4:30 but Webex shows 3:30
// // 'Africa/Nairobi' => 34,
// // // 'Asia/Baghdad' => 32, ?
// // // 'Asia/Beirut' => 34, ?
// // // 'Asia/Kuwait' => 34, ?
// // 'Asia/Riyadh' => 32,
// // // 'Europe/Minsk' => 33, ?
// // 'Africa/Cairo' => 28,
// // // 'Africa/Johannesburg' => 157, ?
// // // 'Asia/Jerusalem' => 32, ?
// // 'Europe/Athens' => 26, // 3 but webex shows 2
// // 'Europe/Bucharest' => 27,
// // 'Europe/Helsinki' => 30,
// // 'Europe/Istanbul' => 140,
// // 'Africa/Algiers' => 143,
// // 'Africa/Casablanca' => 136,
// // 'Europe/Amsterdam' => 22, // 2 but webex shows 1
// // 'Europe/Berlin' => 25, // 2 but webex shows 1
// // 'Europe/Brussels' => 147, // 2 but webex shows 1
// // 'Europe/Paris' => 23, // 2 but webex shows 1
// // 'Europe/Prague' => 24, // 2 but wwebex shows 1
// // 'Europe/Rome' => 142, // 2 but webex shows 1
// // 'Europe/Dublin' => 163, // 1 but webex shows 0
// // 'Europe/Lisbon' => 161, // 1 but 0
// // 'Europe/London' => 21, // 1 but 0
// // 'GMT' => 20,
// // 'Atlantic/Azores' => 19, // 1 but -1
// // // 'America/Scoresbysund' => 2, 0
// // 'Atlantic/Cape_Verde' => 150,
// // // 'America/Sao_Paulo' => 17, ?
// // // 'Atlantic/South_Georgia' => 18, ?
// // 'America/Argentina/Buenos_Aires' => 17,
// // 'America/Santiago' => 145, // -4 but -3
// // // 'America/St_Johns' => 2, -2.3
// // 'America/Halifax' => 13, // -3 but -4
// // // 'America/Puerto_Rico' => 133, ?
// // // 'Atlantic/Bermuda' => 16, ?
// // 'America/Caracas' => 133,
// // 'America/Bogota' => 10,
// // 'America/Indiana/Indianapolis' => 12, // -4 but -5
// // // 'America/Lima' => 10, ?
// // 'America/New_York' => 11, // -4 but -5
// // 'America/Panama' => 146,
// // 'America/Chicago' => 7, // -5 but -6
// // // 'America/El_Salvador' => 7, ?
// // // 'America/Mazatlan' => 7, ?
// // 'America/Mexico_City' => 8, // -5 but -6
// // 'America/Denver' => 6,  // -6 but -7
// // 'America/Phoenix' => 4, -7
// // 'America/Los_Angeles' => 4, -7
// // 'America/Tijuana' => 131, // -7 but -8
// // // 'Pacific/Marquesas' => 2, -9:30
// // // 'Pacific/Gambier' => 4, ?
// // // 'Pacific/Pitcairn' => 4, ?
// // // 'America/Adak' => 4, ?
// // 'America/Anchorage' => 3, // -8 but -9
// // 'Pacific/Honolulu' => 2,
// // // 'Pacific/Niue' => 2, -11
// // // 'Pacific/Pago_Pago' => 2, -11
// //   };

// Map<String, Integer> timeZoneWBX = new Map<String, Integer>{
// 'Pacific/Fiji' => 61,
// 'Pacific/Tongatapu' => 153,
// 'Asia/Kamchatka' => 60,
// 'Australia/Sydney' => 55, 
// 'Pacific/Guadalcanal' => 59,
// 'Australia/Adelaide' => 52,
// 'Australia/Darwin' => 53,
// 'Asia/Seoul' => 50,
// 'Asia/Tokyo' => 49,
// 'Asia/Kuala_Lumpur' => 134, 
// 'Asia/Singapore' => 47, 
// 'Asia/Taipei' => 48, 
// 'Australia/Perth' => 46,
// 'Asia/Bangkok' => 44,
// 'Asia/Jakarta' => 154, 
// 'Asia/Yekaterinburg' => 39, 
// 'Asia/Kathmandu' => 141,
// 'Asia/Colombo' => 42, 
// 'Asia/Kabul' => 38, 
// 'Asia/Dubai' => 36,
// 'Europe/Moscow' => 33,
// 'Asia/Yerevan' => 155,
// 'Asia/Tehran' => 2,
// 'Africa/Nairobi' => 34,
// 'Asia/Riyadh' => 32,
// 'Africa/Cairo' => 28,
// 'Europe/Athens' => 26, 
// 'Europe/Bucharest' => 27,
// 'Europe/Helsinki' => 30,
// 'Europe/Istanbul' => 140,
// 'Africa/Algiers' => 143,
// 'Africa/Casablanca' => 136,
// 'Europe/Amsterdam' => 22, 
// 'Europe/Berlin' => 25, 
// 'Europe/Brussels' => 147, 
// 'Europe/Paris' => 23, 
// 'Europe/Prague' => 24, 
// 'Europe/Rome' => 142, 
// 'Europe/Dublin' => 163, 
// 'Europe/Lisbon' => 161, 
// 'Europe/London' => 21, 
// 'GMT' => 20,
// 'Atlantic/Azores' => 19,
// 'Atlantic/Cape_Verde' => 150,
// 'America/Argentina/Buenos_Aires' => 17,
// 'America/Santiago' => 145,
// 'America/Halifax' => 13,
// 'America/Caracas' => 133,
// 'America/Bogota' => 10,
// 'America/Indiana/Indianapolis' => 12,
// 'America/New_York' => 11,
// 'America/Panama' => 146,
// 'America/Chicago' => 7,
// 'America/Mexico_City' => 8,
// 'America/Denver' => 6, 
// 'America/Phoenix' => 4,
// 'America/Los_Angeles' => 4,
// 'America/Tijuana' => 131,
// 'America/Anchorage' => 3,
// 'Pacific/Honolulu' => 2 
// };

// Integer timeZoneFinalID = timeZoneWBX.get(users.get(0).TimeZoneSidKey);
// if (timeZoneFinalID == null) {
//   System.debug('No supported timezone found, assigning to GMT 00:00');
//   timeZoneFinalID = 20; // GMT 00:00
// }

// // System.debug('timeZoneWBX A: ' + users);
// System.debug('timeZoneSidKey: ' + users.get(0).TimeZoneSidKey);
// System.debug('timeZoneWBX Id: ' + timeZoneFinalID);
// // System.debug('timeZoneWBX B: ' + timeZoneWBX);

// String txtInvite = '';
// txtInvite += 'BEGIN:VCALENDAR\n';
// txtInvite += 'VERSION:2.0\n';
// txtInvite += 'PRODID:-//Example Corp.//CalDAV Server//EN\n';
// txtInvite += 'METHOD:REQUEST\n';
// txtInvite += 'BEGIN:VEVENT\n';
// txtInvite += 'UID:9263504FD3AD\n';
// txtInvite += 'SEQUENCE:1\n';
// txtInvite += 'DTSTAMP:20210902T185254Z\n';
// txtInvite += 'DTSTART:20210902T160000Z\n';
// txtInvite += 'DTEND:20210902T170000Z\n';
// txtInvite += 'TRANSP:OPAQUE\n';
// txtInvite += 'SUMMARY:Lunch\n';
// txtInvite += 'ORGANIZER;CN="Viseven":mailto:n.pidhirnyi@viseven.com\n';
// txtInvite += 'ATTENDEE;CN="Viseven";CUTYPE=INDIVIDUAL;PARTSTAT=ACCEPTED:mailto:n.pidhirnyi@viseven.com\n';
// txtInvite += 'ATTENDEE;CN="Gmail";CUTYPE=INDIVIDUAL;PARTSTAT=NEEDS-ACTION;ROLE=REQ-PARTICIPANT;RSVP=TRUE:mailto:nazar.pidhirnyi@gmail.com\n';
// txtInvite += 'END:VEVENT\n';
// txtInvite += 'END:VCALENDAR\n';
// Blob body = Blob.valueOf(txtInvite);


// Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
// attach.filename = 'meeting.ics';
// attach.ContentType = 'text/calendar;';
// attach.inline = true;
// attach.body = body;


// Messaging.SingleEmailMessage emailToSend = new Messaging.SingleEmailMessage();
// emailToSend.setSenderDisplayName('test sender name');
// emailToSend.setPlainTextBody('test plain text body');
// emailToSend.setHTMLBody('test body');
// emailToSend.setSubject('test subject');
// String[] toAddrs = new String[]{​​​​​​'nazar.pidhirnyi@gmail.com', 'n.pidhirnyi@viseven.com'}​​​​​​;
// emailToSend.setToAddresses(toAddrs);
// emailToSend.setFileAttachments(new Messaging.EmailFileAttachment[]{​​​​​​attach}​​​​​​);
// Messaging.reserveSingleEmailCapacity(1);
// Messaging.SendEmailResult[] sendRes = Messaging.sendEmail(new Messaging.SingleEmailMessage[]{​​​​​​emailToSend}​​​​​​);


String txtInvite = '';
txtInvite += 'BEGIN:VCALENDAR\n';
txtInvite += 'VERSION:2.0\n';
txtInvite += 'PRODID:-//Example Corp.//CalDAV Server//EN\n';
txtInvite += 'METHOD:REQUEST\n';
txtInvite += 'BEGIN:VEVENT\n';
txtInvite += 'UID:9263504FD3AD\n';
txtInvite += 'SEQUENCE:1\n';
txtInvite += 'DTSTAMP:20210902T185254Z\n';
txtInvite += 'DTSTART:20210902T190000Z\n';
txtInvite += 'DTEND:20210902T200000Z\n';
txtInvite += 'TRANSP:OPAQUE\n';
txtInvite += 'SUMMARY:Lunch\n';
txtInvite += 'ORGANIZER;CN="Viseven":mailto:n.pidhirnyi@viseven.com\n';
txtInvite += 'ATTENDEE;CN="Viseven";CUTYPE=INDIVIDUAL;PARTSTAT=ACCEPTED:mailto:n.pidhirnyi@viseven.com\n';
txtInvite += 'ATTENDEE;CN="Gmail";CUTYPE=INDIVIDUAL;PARTSTAT=NEEDS-ACTION;ROLE=REQ-PARTICIPANT;RSVP=TRUE:mailto:nazar.pidhirnyi@gmail.com\n';
// txtInvite += 'LOCATION:https://myabbottdev.webex.com/myabbottdev-ru/onstage/g.php?MTID=ef533ecbb6c32c8c02345a78feed4eaf4\n';
// txtInvite += 'DESCRIPTION:Event Name: 45 min meeting with Dmytro\n\nLocation: This is a';
// txtInvite += 'Google Meet web conference.\nYou can join this meeting from your computer\,'; 
// txtInvite += 'tablet, or smartphone.\nhttps://calendly.com/events/HNGGGLYO36Q74BE4/googl';
// txtInvite += 'e_meet\n\nPurpose of the meeting: Salesforce Developer position interview\n';
// txtInvite += '\nNeed to make changes to this event?\nCancel: https://calendly.com/cancell';
// txtInvite += 'ations/EMCRQV6QYNSGUE4I\nReschedule: https://calendly.com/reschedulings/EMC';
// txtInvite += 'RQV6QYNSGUE4I\n\nPowered by Calendly.com\n\n\n-::~:~::~:~:~:~:~:~:~:~:~:~:~';
// txtInvite += ':~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~::~:~::-\nDo not edit thi';
// txtInvite += 's section of the description.\n\nThis event has a video call.\nJoin: https:';
// txtInvite += '//meet.google.com/gzc-rrcb-wik\n(GB) +44 20 3937 4678 PIN: 105437719#\nView';
// txtInvite += ' more phone numbers: https://tel.meet/gzc-rrcb-wik?pin=9302962200410&hs=7\n';
// txtInvite += '-::~:~::~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~';
// txtInvite += ':~:~::~:~::-';
// txtInvite += 'DESCRIPTION:Event Name: 45 min meeting with Dmytro\n\nLocation: This is a Google Meet web conference.\nYou can join this meeting from your computer\, tablet\, or smartphone.\nhttps://calendly.com/events/HNGGGLYO36Q74BE4/googl e_meet\n\nPurpose of the meeting: Salesforce Developer position interview\n \nNeed to make changes to this event?\nCancel: https://calendly.com/cancell ations/EMCRQV6QYNSGUE4I\nReschedule: https://calendly.com/reschedulings/EMC RQV6QYNSGUE4I\n\nPowered by Calendly.com\n\n\n-::~:~::~:~:~:~:~:~:~:~:~:~:~ :~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~::~:~::-\nDo not edit thi s section of the description.\n\nThis event has a video call.\nJoin: https: //meet.google.com/gzc-rrcb-wik\n(GB) +44 20 3937 4678 PIN: 105437719#\nView  more phone numbers: https://tel.meet/gzc-rrcb-wik?pin=9302962200410&hs=7\n -::~:~::~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~ :~:~::~:~::-';
txtInvite += 'END:VEVENT\n';
txtInvite += 'END:VCALENDAR\n';
Blob body = Blob.valueOf(txtInvite);


Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
attach.filename = 'meeting.ics';
attach.ContentType = 'text/calendar;';
attach.inline = true;
attach.body = body;


Messaging.SingleEmailMessage emailToSend = new Messaging.SingleEmailMessage();
emailToSend.setSenderDisplayName('test sender name');
emailToSend.setPlainTextBody('test plain text body');
emailToSend.setHTMLBody('test body');
emailToSend.setSubject('test subject');
String[] toAddrs = new String[]{'nazar.pidhirnyi@gmail.com', 'n.pidhirnyi@viseven.com' };
emailToSend.setToAddresses(toAddrs);
emailToSend.setFileAttachments(new Messaging.EmailFileAttachment[] {attach});
Messaging.reserveSingleEmailCapacity(1);
Messaging.SendEmailResult[] sendRes = Messaging.sendEmail(new Messaging.SingleEmailMessage[]{emailToSend});