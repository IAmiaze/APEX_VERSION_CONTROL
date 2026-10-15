prompt --application/pages/page_00000
begin
--   Manifest
--     PAGE: 00000
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2026.03.30'
,p_release=>'26.1.0'
,p_default_workspace_id=>1000393
,p_default_application_id=>100
,p_default_id_offset=>0
,p_default_owner=>'MIAZE'
);
wwv_flow_imp_page.create_page(
 p_id=>0
,p_name=>'Global Page'
,p_reload_on_submit=>null
,p_warn_on_unsaved_changes=>null
,p_autocomplete_on_off=>'OFF'
,p_protection_level=>'D'
,p_page_component_map=>'14'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(2201324801172207)
,p_plug_name=>'Language Selector'
,p_static_id=>'language-selector_1'
,p_title=>'&{LANGUAGE_SELECTOR}.'
,p_region_css_classes=>'u-pull-right'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>4502917002193490937
,p_plug_display_sequence=>20
,p_plug_display_point=>'BEFORE_NAVIGATION_BAR'
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_function_body_language=>'PLSQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    l_current_lang VARCHAR2(10) := LOWER(apex_util.get_session_lang);',
'    l_next_lang    VARCHAR2(10);',
'    l_is_checked   BOOLEAN;',
'BEGIN',
'    -- Determine current state and target language',
'    IF l_current_lang LIKE ''bn%'' THEN',
'        l_next_lang  := ''en'';',
'        l_is_checked := TRUE; -- Switch ON for Bangla',
'    ELSE',
'        l_next_lang  := ''bn'';',
'        l_is_checked := FALSE; -- Switch OFF for English',
'    END IF;',
'',
'    RETURN ',
'      ''<div class="lang-switch-wrapper">'' ||',
'        ''<span class="lang-label '' || CASE WHEN NOT l_is_checked THEN ''is-active'' END || ''">EN</span>'' ||',
'        ''<button type="button" class="lang-switch-toggle" onclick="switchLanguage('''''' || l_next_lang || '''''')">'' ||',
'          ''<span class="lang-switch-slider '' || CASE WHEN l_is_checked THEN ''is-checked'' END || ''"></span>'' ||',
'        ''</button>'' ||',
unistr('        ''<span class="lang-label lang-label-bn '' || CASE WHEN l_is_checked THEN ''is-active'' END || ''">\09AC\09BE\0982\09B2\09BE</span></div>'' ;'),
'END;'))
,p_lazy_loading=>false
,p_plug_source_type=>'NATIVE_DYNAMIC_CONTENT'
,p_plug_header=>'&{PLUG_HEADER}!RAW.'
);
wwv_flow_imp.component_end;
end;
/
