// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faq.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Faq _$FaqFromJson(Map<String, dynamic> json) => Faq(
      id: (json['id'] as num?)?.toInt(),
      answer: json['answer'] as String?,
      status: json['status'] as String?,
      category: json['category'] as String?,
      question: json['question'] as String?,
      displayOrder: (json['display_order'] as num?)?.toInt(),
    );

Map<String, dynamic> _$FaqToJson(Faq instance) => <String, dynamic>{
      'id': instance.id,
      'answer': instance.answer,
      'status': instance.status,
      'question': instance.question,
      'category': instance.category,
      'display_order': instance.displayOrder,
    };
