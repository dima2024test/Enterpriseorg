public class UpdatePharosLog {
    public static void updateCreatedAt() {
        // Определяем новые значения для поля
        DateTime newCreatedAt = DateTime.newInstance(2025, 9, 11, 16, 23, 26); // Новое значение

        // Получаем записи pharos__log__c в указанном диапазоне дат
        List<pharos__log__c> logsToUpdate = [
            SELECT Id, Name, pharos__Category__c, pharos__Created_At__c 
            FROM pharos__Log__c 
            WHERE pharos__Created_At__c = today AND pharos__Category__c = 'Apex'
           // < 2025-09-22T16:23:26Z AND pharos__Created_At__c > 2025-09-22T16:16:07Z
        ];

        // Проверка, были ли найдены записи
        System.debug('Records found: ' + logsToUpdate.size());

        // Обновляем поле pharos__created_at__c
        for (pharos__log__c log : logsToUpdate) {
            log.pharos__Created_At__c = newCreatedAt;
        }

        // Выполняем обновление записей
        if (!logsToUpdate.isEmpty()) {
            update logsToUpdate;
            System.debug('Records updated successfully');
        } else {
            System.debug('No records to update');
        }
    }
}