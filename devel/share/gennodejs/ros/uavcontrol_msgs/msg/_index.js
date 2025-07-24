
"use strict";

let UAVControlState = require('./UAVControlState.js');
let PolynomialTrajectory = require('./PolynomialTrajectory.js');
let LedStates = require('./LedStates.js');
let Serial = require('./Serial.js');
let LivoxCustomMsg = require('./LivoxCustomMsg.js');
let CustomDataSegment = require('./CustomDataSegment.js');
let GimbalControl = require('./GimbalControl.js');
let Odometry = require('./Odometry.js');
let MultiUGVState = require('./MultiUGVState.js');
let PositionCommand = require('./PositionCommand.js');
let WindowPosition = require('./WindowPosition.js');
let ShoutStates = require('./ShoutStates.js');
let GeoFence = require('./GeoFence.js');
let UAVState = require('./UAVState.js');
let VisionDiff = require('./VisionDiff.js');
let FormationAssign = require('./FormationAssign.js');
let GPSData = require('./GPSData.js');
let BoundingBoxes = require('./BoundingBoxes.js');
let PPROutputData = require('./PPROutputData.js');
let Bspline = require('./Bspline.js');
let MultiArucoInfo = require('./MultiArucoInfo.js');
let MultiDetectionInfoSub = require('./MultiDetectionInfoSub.js');
let StationCommand = require('./StationCommand.js');
let LivoxCustomPoint = require('./LivoxCustomPoint.js');
let LQRTrajectory = require('./LQRTrajectory.js');
let OutputData = require('./OutputData.js');
let LinktrackNode2 = require('./LinktrackNode2.js');
let LinktrackNodeframe2 = require('./LinktrackNodeframe2.js');
let SwarmCommand = require('./SwarmCommand.js');
let GlobalAruco = require('./GlobalAruco.js');
let UAVSetup = require('./UAVSetup.js');
let Corrections = require('./Corrections.js');
let GimbalState = require('./GimbalState.js');
let UGVCommand = require('./UGVCommand.js');
let StatusData = require('./StatusData.js');
let TextInfo = require('./TextInfo.js');
let MultiDetectionInfo = require('./MultiDetectionInfo.js');
let ArucoInfo = require('./ArucoInfo.js');
let BasicDataTypeAndValue = require('./BasicDataTypeAndValue.js');
let DetectionInfo = require('./DetectionInfo.js');
let PositionReference = require('./PositionReference.js');
let MultiBsplines = require('./MultiBsplines.js');
let Px4ctrlDebug = require('./Px4ctrlDebug.js');
let UGVState = require('./UGVState.js');
let AuxCommand = require('./AuxCommand.js');
let Control = require('./Control.js');
let MultiUAVState = require('./MultiUAVState.js');
let SO3Command = require('./SO3Command.js');
let OffsetPose = require('./OffsetPose.js');
let BoundingBox = require('./BoundingBox.js');
let TRPYCommand = require('./TRPYCommand.js');
let ParamSettings = require('./ParamSettings.js');
let UAVCommand = require('./UAVCommand.js');
let DetectionInfoSub = require('./DetectionInfoSub.js');
let Gains = require('./Gains.js');
let CheckForObjectsActionGoal = require('./CheckForObjectsActionGoal.js');
let CheckForObjectsGoal = require('./CheckForObjectsGoal.js');
let CheckForObjectsResult = require('./CheckForObjectsResult.js');
let CheckForObjectsActionFeedback = require('./CheckForObjectsActionFeedback.js');
let CheckForObjectsAction = require('./CheckForObjectsAction.js');
let CheckForObjectsActionResult = require('./CheckForObjectsActionResult.js');
let CheckForObjectsFeedback = require('./CheckForObjectsFeedback.js');

module.exports = {
  UAVControlState: UAVControlState,
  PolynomialTrajectory: PolynomialTrajectory,
  LedStates: LedStates,
  Serial: Serial,
  LivoxCustomMsg: LivoxCustomMsg,
  CustomDataSegment: CustomDataSegment,
  GimbalControl: GimbalControl,
  Odometry: Odometry,
  MultiUGVState: MultiUGVState,
  PositionCommand: PositionCommand,
  WindowPosition: WindowPosition,
  ShoutStates: ShoutStates,
  GeoFence: GeoFence,
  UAVState: UAVState,
  VisionDiff: VisionDiff,
  FormationAssign: FormationAssign,
  GPSData: GPSData,
  BoundingBoxes: BoundingBoxes,
  PPROutputData: PPROutputData,
  Bspline: Bspline,
  MultiArucoInfo: MultiArucoInfo,
  MultiDetectionInfoSub: MultiDetectionInfoSub,
  StationCommand: StationCommand,
  LivoxCustomPoint: LivoxCustomPoint,
  LQRTrajectory: LQRTrajectory,
  OutputData: OutputData,
  LinktrackNode2: LinktrackNode2,
  LinktrackNodeframe2: LinktrackNodeframe2,
  SwarmCommand: SwarmCommand,
  GlobalAruco: GlobalAruco,
  UAVSetup: UAVSetup,
  Corrections: Corrections,
  GimbalState: GimbalState,
  UGVCommand: UGVCommand,
  StatusData: StatusData,
  TextInfo: TextInfo,
  MultiDetectionInfo: MultiDetectionInfo,
  ArucoInfo: ArucoInfo,
  BasicDataTypeAndValue: BasicDataTypeAndValue,
  DetectionInfo: DetectionInfo,
  PositionReference: PositionReference,
  MultiBsplines: MultiBsplines,
  Px4ctrlDebug: Px4ctrlDebug,
  UGVState: UGVState,
  AuxCommand: AuxCommand,
  Control: Control,
  MultiUAVState: MultiUAVState,
  SO3Command: SO3Command,
  OffsetPose: OffsetPose,
  BoundingBox: BoundingBox,
  TRPYCommand: TRPYCommand,
  ParamSettings: ParamSettings,
  UAVCommand: UAVCommand,
  DetectionInfoSub: DetectionInfoSub,
  Gains: Gains,
  CheckForObjectsActionGoal: CheckForObjectsActionGoal,
  CheckForObjectsGoal: CheckForObjectsGoal,
  CheckForObjectsResult: CheckForObjectsResult,
  CheckForObjectsActionFeedback: CheckForObjectsActionFeedback,
  CheckForObjectsAction: CheckForObjectsAction,
  CheckForObjectsActionResult: CheckForObjectsActionResult,
  CheckForObjectsFeedback: CheckForObjectsFeedback,
};
