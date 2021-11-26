/*
1. Найти все Job Applications созданные за последнюю неделю, у которых овнером являются юзеры с профилем Рекрутер, и связанные с ними Reviews, Positions, Candidates.
*/

List<Job_Application__c> jobApps = [
  SELECT
    Name,
    OwnerId,
    CreatedDate,
    Position__r.Name,
    Candidate__r.Name,
    (SELECT Name, Grade__c FROM Reviews__r)
  FROM Job_Application__c
  WHERE CreatedDate = LAST_N_DAYS:7 AND OwnerId IN (SELECT Id FROM User WHERE Profile.Name = 'Recruiter')
];

System.debug(jobApps);

/*
2. Найти все позиции, всех кандидатов и все ревью, которые были созданы более недели назад, у которых встречается слово 'develop'.
*/

List<List<SObject>> developList = [
  FIND 'develop*'
  IN ALL FIELDS
  RETURNING
    Review__c(Name, CreatedDate WHERE CreatedDate < LAST_N_DAYS:7),
    Position__c(Name, CreatedDate WHERE CreatedDate < LAST_N_DAYS:7),
    Candidate__c(Name, CreatedDate WHERE CreatedDate < LAST_N_DAYS:7)
];

System.debug(developList);
