import 'package:base_flutter/src/core/data/constants.dart';
import 'package:base_flutter/src/core/models/image_model.dart';

import 'package:base_flutter/src/core/models/post_model.dart';
import 'package:base_flutter/src/core/networks/api_service_model.dart';
import 'package:base_flutter/src/core/networks/network_helper.dart';
import 'package:dio/dio.dart';

class PostRepository {
  final NetworkHelper _networkHelper;

  PostRepository(this._networkHelper);

  Future<ApiServiceModel<ListPost>> getListPost(int page) async {
    final params = {
      '_page': page,
      '_limit': Constants.POST_PAGE_SIZE,
    };
    final Response<dynamic> response =
        await _networkHelper.get('posts', query: params) as Response<dynamic>;
    return ApiServiceModel.fromList(response, ListPost.fromJson);
  }

  Future<ApiServiceModel<ImageModels>> uploadAttachment({
    required String path,
    String module = 'post_image',
    String? fileName,
  }) async {
    try {
      FormData formData = FormData();
      formData.fields.add(MapEntry('module', module));
      if (path.isNotEmpty) {
        formData.files.add(
          MapEntry(
              'attachment',
              await MultipartFile.fromFile(
                path,
                filename: fileName ?? path.split('/').last,
              )),
        );
      }
      _networkHelper.mockAdapter().onPost(
            'https://example.com',
            (server) => server.reply(
              200,
              Constants.uploadImage,
            ),
            data: formData,
          );

      final response = await _networkHelper.postMultipart(
        url: 'https://example.com',
        data: formData,
        contentLength: formData.length,
      );
      final serviceModel = ApiServiceModel<ImageModels>.fromResponse(
          response, ImageModels.fromJson);

      return serviceModel;
    } catch (e) {
      rethrow;
    }
  }
}
