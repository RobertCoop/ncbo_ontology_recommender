require_relative '../test_case'
require_relative '../../lib/ncbo_ontology_recommender/utils/annotator_utils/annotator_utils'


class TestAnnotatorUtils < TestCase

  def self.before_suite
    @@custom_annotation = OntologyRecommender::Utils::AnnotatorUtils::CustomAnnotation
  end

  def self.after_suite
  end

  def test_get_annotations
    # TODO
  end

  def test_get_keyword_annotations
    input = 'melanoma, white blood cell, arm, cavity of stomach, melanoma'
    delimiter = ','
    a1 = @@custom_annotation.new(1, 8, 'PREF', 'MELANOMA', nil, 0)
    a2 = @@custom_annotation.new(11, 26, 'PREF', 'WHITE BLOOD CELL', nil, 0)
    a3 = @@custom_annotation.new(29, 31, 'SYN', 'ARM', nil, 0)
    a4 = @@custom_annotation.new(17, 26, 'SYN', 'BLOOD CELL', nil, 0)
    a5 = @@custom_annotation.new(17, 21, 'PREF', 'BLOOD', nil, 0)
    a6 = @@custom_annotation.new(34, 50, 'PREF', 'CAVITY OF STOMACH', nil, 0)
    a7 = @@custom_annotation.new(53, 60, 'PREF', 'MELANOMA', nil, 0)
    anns = OntologyRecommender::Utils::AnnotatorUtils.get_keyword_annotations(input, delimiter, [a1, a2, a3, a4, a5, a6, a7])
    exp_anns = [a1, a2, a3, a6, a7]
    assert_equal(exp_anns.sort, anns.sort)
  end

  def test_get_annotations_for_fragment
    a1 = @@custom_annotation.new(1, 8, 'PREF', 'MELANOMA', nil, 0)
    a2 = @@custom_annotation.new(11, 26, 'PREF', 'WHITE BLOOD CELL', nil, 0)
    a3 = @@custom_annotation.new(29, 36, 'PREF', 'MELANOMA', nil, 0)
    a4 = @@custom_annotation.new(43, 45, 'SYN', 'ARM', nil, 0)
    a5 = @@custom_annotation.new(40, 55, 'PREF', 'WHITE BLOOD CELL', nil, 0)
    a6 = @@custom_annotation.new(17, 26, 'SYN', 'BLOOD CELL', nil, 0)
    a7 = @@custom_annotation.new(17, 21, 'PREF', 'BLOOD', nil, 0)
    anns = OntologyRecommender::Utils::AnnotatorUtils.get_annotations_for_fragment(17, 21, [a1, a2, a3, a4, a5, a6, a7])
    exp_anns = [a6, a7]
    assert_equal(exp_anns.sort, anns.sort)
  end

  def test_get_keyword_positions
    delimiter = ','
    input = '   melanoma, head,stomach,   ,z,  , white blood cell  ,...leg   , ,, 123heart,  '
    keywords = ['melanoma', 'head', 'stomach', 'z', 'white blood cell', '...leg', '123heart']
    reference_positions = []
    keywords.each do |k|
      start = input.index(k) + 1
      reference_positions.push(OntologyRecommender::Utils::AnnotatorUtils::TextPosition.new(start, start + k.length-1))
    end
    keyword_positions = OntologyRecommender::Utils::AnnotatorUtils.get_keyword_positions(input, delimiter)
    assert_equal(reference_positions, keyword_positions)
  end

end