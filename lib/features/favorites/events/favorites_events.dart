import 'package:rick_morty_app/core/services/firebase_analitics/event.dart';

class ToggleFavoriteEvent extends Event {
  ToggleFavoriteEvent(int characterId)
    : super(
        name: 'Toggle_Favorite_Event',
        params: {'Character Id': characterId},
      );
}
