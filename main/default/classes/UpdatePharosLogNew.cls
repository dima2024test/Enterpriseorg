public class UpdatePharosLogNew {
    public static void updateCreatedAt() {
        // Определяем новые значения для поля
        DateTime newCreatedAt = DateTime.newInstance(2025, 9, 23, 16, 23, 26);

        // Получаем записи pharos__log__c (более широкий диапазон для тестирования)
        List<pharos__log__c> logsToUpdate = [
            SELECT Id, Name, pharos__Created_At__c 
            FROM pharos__Log__c 
            WHERE pharos__Created_At__c = today and pharos__Category__c = 'Apex' LIMIT 500
            //pharos__Created_At__c < :DateTime.newInstance(2025, 9, 23, 16, 23, 26) 
            //AND pharos__Created_At__c > :DateTime.newInstance(2025, 1, 1, 0, 0, 0) // Широкий диапазон
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