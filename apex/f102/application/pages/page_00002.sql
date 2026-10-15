prompt --application/pages/page_00002
begin
--   Manifest
--     PAGE: 00002
--   Manifest End
wwv_flow_imp.component_begin (
 p_version_yyyy_mm_dd=>'2026.03.30'
,p_release=>'26.1.0'
,p_default_workspace_id=>1000393
,p_default_application_id=>102
,p_default_id_offset=>0
,p_default_owner=>'MIAZE'
);
wwv_flow_imp_page.create_page(
 p_id=>2
,p_name=>'Dynamic voice testing'
,p_alias=>'DYNAMIC-VOICE-TESTING'
,p_step_title=>'Dynamic voice testing'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'async function triggerAnnouncementAndClearForm() {',
'    // 1. Read Page 2 APEX Items Dynamically',
'    const customerName = apex.item("P2_CUSTOMER_NAME").getValue();',
'    const orderId      = apex.item("P2_ORDER_ID").getValue();',
'    const amount       = apex.item("P2_AMOUNT").getValue();',
'',
'    // Only proceed if transaction data exists',
'    if (!customerName && !orderId && !amount) return;',
'',
'    // 2. Initialize Web Audio Context',
'    const audioCtx = new (window.AudioContext || window.webkitAudioContext)();',
'    if (audioCtx.state === ''suspended'') {',
'        await audioCtx.resume();',
'    }',
'',
'    const startTime = audioCtx.currentTime + 0.05;',
'',
'    // 3. Synthesize Chime Tone',
'    function playChimeTone(freq, toneStart, duration) {',
'        const oscPrimary = audioCtx.createOscillator();',
'        const oscHarmonic = audioCtx.createOscillator();',
'        const gainNode = audioCtx.createGain();',
'',
'        oscPrimary.type = ''sine'';',
'        oscHarmonic.type = ''sine'';',
'',
'        oscPrimary.frequency.setValueAtTime(freq, toneStart);',
'        oscHarmonic.frequency.setValueAtTime(freq * 2.0, toneStart);',
'',
'        const attackTime = 0.008;',
'        gainNode.gain.setValueAtTime(0.0001, toneStart);',
'        gainNode.gain.exponentialRampToValueAtTime(0.20, toneStart + attackTime);',
'        gainNode.gain.exponentialRampToValueAtTime(0.0001, toneStart + duration);',
'',
'        oscPrimary.connect(gainNode);',
'        oscHarmonic.connect(gainNode);',
'',
'        const filter = audioCtx.createBiquadFilter();',
'        filter.type = ''lowpass'';',
'        filter.frequency.setValueAtTime(5000, toneStart);',
'',
'        gainNode.connect(filter);',
'        filter.connect(audioCtx.destination);',
'',
'        oscPrimary.start(toneStart);',
'        oscHarmonic.start(toneStart);',
'        oscPrimary.stop(toneStart + duration);',
'        oscHarmonic.stop(toneStart + duration);',
'    }',
'',
'    // Tuning Parameters',
'    const dingPitch = 659.25;       // E5 (High Ding)',
'    const dongPitch = 493.88;       // B4 (High Dong)',
'    const toneDuration = 0.8;',
'    const gapBetweenTones = 0.45;',
'',
'    playChimeTone(dingPitch, startTime, toneDuration);',
'    playChimeTone(dongPitch, startTime + gapBetweenTones, toneDuration);',
'',
'    const voiceStartTime = startTime + gapBetweenTones + 0.70;',
'',
'    // 4. Fetch MP3 Audio Stream from Python Server',
'    try {',
'        const serverHost = window.location.hostname || "localhost";',
'        const response = await fetch(`http://${serverHost}:5000/api/confirm-order-voice`, {',
'            method: ''POST'',',
'            headers: { ''Content-Type'': ''application/json'' },',
'            body: JSON.stringify({',
'                customer_name: customerName,',
'                order_id: orderId,',
'                amount: amount',
'            })',
'        });',
'',
'        if (!response.ok) throw new Error(`HTTP Error: ${response.status}`);',
'',
'        const arrayBuffer = await response.arrayBuffer();',
'        const audioBuffer = await audioCtx.decodeAudioData(arrayBuffer);',
'',
'        // 5. Audio Playback Setup',
'        const voiceSource = audioCtx.createBufferSource();',
'        voiceSource.buffer = audioBuffer;',
'',
'        const delayNode = audioCtx.createDelay();',
'        delayNode.delayTime.value = 0.10;',
'',
'        const feedbackGain = audioCtx.createGain();',
'        feedbackGain.gain.value = 0.08;',
'',
'        delayNode.connect(feedbackGain);',
'        feedbackGain.connect(delayNode);',
'',
'        const masterGain = audioCtx.createGain();',
'        masterGain.gain.setValueAtTime(1.0, audioCtx.currentTime);',
'',
'        voiceSource.connect(masterGain);',
'        voiceSource.connect(delayNode);',
'        delayNode.connect(masterGain);',
'        masterGain.connect(audioCtx.destination);',
'',
'        const targetPlaybackTime = Math.max(voiceStartTime, audioCtx.currentTime + 0.05);',
'        voiceSource.start(targetPlaybackTime);',
'',
'        // 6. CLEAR FORM FIELDS AFTER TRIGGERING ANNOUNCEMENT',
'        apex.item("P2_CUSTOMER_NAME").setValue("");',
'        apex.item("P2_ORDER_ID").setValue("");',
'        apex.item("P2_AMOUNT").setValue("");',
'',
'    } catch (err) {',
'        console.error("APEX Voice Announcement Error:", err);',
'    }',
'}',
''))
,p_step_template=>4073832297226169690
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'16'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(8987834189383722)
,p_plug_name=>'Transaction Parameter'
,p_static_id=>'transaction-parameter'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>4073835273271169698
,p_plug_display_sequence=>10
,p_plug_item_display_point=>'ABOVE'
,p_location=>null
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'expand_shortcuts', 'N',
  'output_as', 'HTML')).to_clob
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(8988344155383727)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(8987834189383722)
,p_button_name=>'SUBMIT'
,p_static_id=>'submit'
,p_show_as_disabled=>false
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>4073839297780169708
,p_button_image_alt=>'Submit'
,p_button_position=>'EDIT'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(8988230881383726)
,p_name=>'P2_AMOUNT'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(8987834189383722)
,p_prompt=>'Amount'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(8988065627383724)
,p_name=>'P2_CUSTOMER_NAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(8987834189383722)
,p_prompt=>'Customer Name'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(8988133228383725)
,p_name=>'P2_ORDER_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(8987834189383722)
,p_prompt=>'Transaction ID'
,p_source_type=>'ALWAYS_NULL'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>1610598304472262251
,p_item_template_options=>'#DEFAULT#'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'disabled', 'N',
  'submit_when_enter_pressed', 'N',
  'subtype', 'TEXT',
  'trim_spaces', 'BOTH')).to_clob
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(8988477248383728)
,p_name=>'Play Audio After Submit'
,p_static_id=>'play-audio-after-submit'
,p_event_sequence=>10
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(8988579720383729)
,p_event_id=>wwv_flow_imp.id(8988477248383728)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_static_id=>'native-javascript-code'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attributes=>wwv_flow_t_plugin_attributes(wwv_flow_t_varchar2(
  'js_code', 'triggerAnnouncementAndClearForm();')).to_clob
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(8988634798383730)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'New'
,p_static_id=>'new'
,p_process_sql_clob=>'NULL;'
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Transaction Submitted!'
,p_internal_uid=>8988634798383730
);
wwv_flow_imp.component_end;
end;
/
