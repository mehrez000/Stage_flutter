import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_choice_chips.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateCompetitionPageWidget extends StatefulWidget {
  const UpdateCompetitionPageWidget({
    Key? key,
    this.ref,
  }) : super(key: key);

  final DocumentReference? ref;

  @override
  _UpdateCompetitionPageWidgetState createState() =>
      _UpdateCompetitionPageWidgetState();
}

class _UpdateCompetitionPageWidgetState
    extends State<UpdateCompetitionPageWidget> {
  DateTime? datePicked;
  TextEditingController? nomController;
  List<String>? choiceChipsValues;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: FaIcon(
            FontAwesomeIcons.arrowLeft,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () async {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Modifier une Compétition',
          style: FlutterFlowTheme.of(context).title2.override(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontSize: 20,
              ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 2,
      ),
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      body: SafeArea(
        child: StreamBuilder<CompetitionsRecord>(
          stream: CompetitionsRecord.getDocument(widget.ref!),
          builder: (context, snapshot) {
            // Customize what your widget looks like when it's loading.
            if (!snapshot.hasData) {
              return Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    color: FlutterFlowTheme.of(context).primaryColor,
                  ),
                ),
              );
            }
            final columnCompetitionsRecord = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 16, 20, 16),
                    child: StreamBuilder<CompetitionsRecord>(
                      stream: CompetitionsRecord.getDocument(widget.ref!),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator(
                                color:
                                    FlutterFlowTheme.of(context).primaryColor,
                              ),
                            ),
                          );
                        }
                        final nomCompetitionsRecord = snapshot.data!;
                        return TextFormField(
                          controller: nomController ??= TextEditingController(
                            text: nomCompetitionsRecord.nom,
                          ),
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'nom',
                            labelStyle: FlutterFlowTheme.of(context).bodyText2,
                            hintStyle: FlutterFlowTheme.of(context).bodyText2,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            contentPadding:
                                EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
                          ),
                          style: FlutterFlowTheme.of(context).bodyText1,
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(30, 0, 0, 0),
                        child: Text(
                          'Date de Competition: ',
                          style: FlutterFlowTheme.of(context).bodyText1,
                        ),
                      ),
                      StreamBuilder<CompetitionsRecord>(
                        stream: CompetitionsRecord.getDocument(widget.ref!),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: CircularProgressIndicator(
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
                                ),
                              ),
                            );
                          }
                          final iconButtonCompetitionsRecord = snapshot.data!;
                          return FlutterFlowIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 30,
                            borderWidth: 1,
                            buttonSize: 60,
                            icon: FaIcon(
                              FontAwesomeIcons.solidCalendarAlt,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 30,
                            ),
                            onPressed: () async {
                              await DatePicker.showDatePicker(
                                context,
                                showTitleActions: true,
                                onConfirm: (date) {
                                  setState(() => datePicked = date);
                                },
                                currentTime:
                                    iconButtonCompetitionsRecord.dateCom!,
                                minTime: DateTime(0, 0, 0),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 195, 0),
                    child: Text(
                      'Formateurs:',
                      style: FlutterFlowTheme.of(context).title3,
                    ),
                  ),
                  StreamBuilder<List<FormateursRecord>>(
                    stream: queryFormateursRecord(),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(
                              color: FlutterFlowTheme.of(context).primaryColor,
                            ),
                          ),
                        );
                      }
                      List<FormateursRecord> choiceChipsFormateursRecordList =
                          snapshot.data!;
                      return FlutterFlowChoiceChips(
                        initiallySelected: choiceChipsValues != null
                            ? choiceChipsValues
                            : columnCompetitionsRecord.tabFormateurs!.toList(),
                        options: choiceChipsFormateursRecordList
                            .map((e) => e.nom!)
                            .toList()
                            .map((label) => ChipData(label))
                            .toList(),
                        onChanged: (val) =>
                            setState(() => choiceChipsValues = val),
                        selectedChipStyle: ChipStyle(
                          backgroundColor: Color(0xFF323B45),
                          textStyle:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                  ),
                          iconColor: Colors.white,
                          iconSize: 18,
                          elevation: 4,
                        ),
                        unselectedChipStyle: ChipStyle(
                          backgroundColor: Colors.white,
                          textStyle:
                              FlutterFlowTheme.of(context).bodyText2.override(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF323B45),
                                  ),
                          iconColor: Color(0xFF323B45),
                          iconSize: 18,
                          elevation: 4,
                        ),
                        chipSpacing: 20,
                        multiselect: true,
                        initialized: choiceChipsValues != null,
                        alignment: WrapAlignment.start,
                      );
                    },
                  ),
                  Align(
                    alignment: AlignmentDirectional(0, 0.05),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                      child: StreamBuilder<List<FormateursRecord>>(
                        stream: queryFormateursRecord(
                          queryBuilder: (formateursRecord) => formateursRecord
                              .whereIn('nom', choiceChipsValues),
                        ),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: CircularProgressIndicator(
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
                                ),
                              ),
                            );
                          }
                          List<FormateursRecord> buttonFormateursRecordList =
                              snapshot.data!;
                          return FFButtonWidget(
                            onPressed: () async {
                              final competitionsUpdateData = {
                                ...createCompetitionsRecordData(
                                  nom: nomController?.text ?? '',
                                  dateCom: datePicked,
                                ),
                                'tabRef': buttonFormateursRecordList
                                    .map((e) => e.reference)
                                    .toList(),
                                'tabFormateurs': choiceChipsValues,
                              };
                              await widget.ref!.update(competitionsUpdateData);
                              Navigator.pop(context);
                            },
                            text: 'Sauvgarder',
                            options: FFButtonOptions(
                              width: 340,
                              height: 60,
                              color: FlutterFlowTheme.of(context).primaryColor,
                              textStyle: FlutterFlowTheme.of(context)
                                  .subtitle2
                                  .override(
                                    fontFamily: 'Lexend Deca',
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                              elevation: 2,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
