
/**
 * Basic search options.
 * These fields are representing only the identifier (Strings) of those objects.
 * e.g. address will be an object of type Address.
 * They are used in SearchPage and stored user searches.
 */
class SearchFinals {
  static const String query = 'query';
  static const String postalCode = 'postalCode';

  static const String pricemin = 'pricemin';
  static const String pricemax = 'pricemax';

  static const String datestart = 'datestart';
  static const String dateend = 'dateend';

  /**
   * Verschiedene Filterungen - animals need different than filtering than barbers
   *
   */

}

class AnimalsSearchFinals extends SearchFinals {
  /**
   * Example cat, dog, bird
   */
  static const String kind = 'kind';
}

class BeautySearchFinals extends SearchFinals {}

class FaceSearchFinals extends SearchFinals {}

class FemaleSearchFinals extends SearchFinals {}

class MaleSearchFinals extends SearchFinals {}

class MassagesSearchFinals extends SearchFinals {}

class PensionersSearchFinals extends SearchFinals {}

class ToolsSearchFinals extends SearchFinals {}
