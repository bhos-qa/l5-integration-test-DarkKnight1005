import 'package:flutter/foundation.dart';
import 'package:tableapptest/consts/api_consts.dart';
import 'package:tableapptest/models/enums/api_level.dart';
import 'package:tableapptest/models/enums/api_schema.dart';
import 'package:tableapptest/utils/extensions/api_level_definer.dart';
import 'package:tableapptest/utils/extensions/api_schema_definer.dart';

class EndpointBuilder {

  EndpointBuilder();

  String _schema = "";
  String _baseUrl = "";
  String _apiIndetifier = "";
  String _apiVersion = "";

  String _endpointBase = "";

  String _endpointParams = "";

  String _savedParams = "";

  void _addBaseParam(String baseParam){
   this._endpointBase += "/$baseParam";
  }

  EndpointBuilder addParam(String param){
    this._endpointParams += "/$param";
    return this;
  }

  EndpointBuilder addPersistentParam(String param){
    this._endpointParams += "/$param";
    return this;
  }

  void _constructBaseEndpoint(){

    if(_schema.isEmpty){
      this.setSchema();
    }
    if(_baseUrl.isEmpty){
      this.setBaseUrl();
    }
    // if(_apiIndetifier.isEmpty){
    //   this.setApiIdentifier();
    // }
    // if(_apiVersion.isEmpty){
    //   this.setApiVersion();
    // }

    this
    .._addSchema()
    .._addBaseUrl();
    // .._addApiIdentifier();
    // .._addApiVersion();

  }

  EndpointBuilder setSchema({ApiSchema? schema}){
    this._schema = schema?.getSchema ?? ApiSchema.HTTPS.getSchema;
    return this;
  }

  void _addSchema(){
    this._endpointBase = this._schema + "://" + this._endpointBase;
  }

  EndpointBuilder setBaseUrl({ApiLevel? apiLevel}){

    this._baseUrl = apiLevel == null ? "" : apiLevel.getBaseUrl;

    if(apiLevel == null){
      if(kReleaseMode){
        this._baseUrl = ApiLevel.PRODUCTION.getBaseUrl;
      }else{
        this._baseUrl = ApiLevel.DEVELOPMENT.getBaseUrl;
      }
    }
    return this;
  }

  void _addBaseUrl(){
    this._endpointBase += this._baseUrl;
  }

  // EndpointBuilder setApiIdentifier([String? apiIdentifer]){
  //   this._apiIndetifier = apiIdentifer ?? ApiConsts.apiIdentifier;
  //   return this;
  // }

  // void _addApiIdentifier(){
  //   this._addBaseParam(this._apiIndetifier);
  // }

    
  // EndpointBuilder setApiVersion([String? version]){
  //   this._apiVersion = version ?? ApiConsts.version;
  //   return this;
  // }

  // void _addApiVersion(){
  //   this._addBaseParam(this._apiVersion);
  // }

  EndpointBuilder saveCurrentParams(){
    this._savedParams += this._endpointParams;
    this._endpointParams = "";
    return this;
  }

 
  String build(){
    this.._constructBaseEndpoint();
    String finalUrl = this._endpointBase + this._savedParams + this._endpointParams;
    this._endpointBase = "";
    this._endpointParams = "";
    return finalUrl;
  }
}