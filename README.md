# Cocktails

Приложение, демонстрирующее работу с использованием сетевых запросов. 
Позволяет отобразить коктейли на основе ингридиентов и получить в отдельном окне детальную информацию о коктейле.

<img width="350" alt="CocktailsViewController" src="https://user-images.githubusercontent.com/50861298/215426059-4382d4ad-5694-41d0-96f7-c63c466c5132.png"><img width="350" alt="DetailedViewController" src="https://user-images.githubusercontent.com/50861298/215426070-dcebd7de-04b4-4f97-ae9e-82c3e746b9ad.png"> 

В проекте создана модель, с помощью которой распарсен JSON. 
Реализована схема MVC с использованием сетевого слоя. 

# Использованые компоненты
 - Данные предоставлены API [TheCocktaildDB](https://www.thecocktaildb.com/)
 - Для отображения информации выбран [UICollectionView](https://developer.apple.com/documentation/uikit/uicollectionview)
 - Для выбора коктейля выбран [UIPickerView](https://developer.apple.com/documentation/uikit/uipickerview)

# Доделать
 - Добавить кеширование данных, т.к. при обновлении в начальный момент картинки отображаются некорректно
 - Убрать дублирование кода
 - Добавить скругление главного вью коктейля
