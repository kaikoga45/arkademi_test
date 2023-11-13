import 'package:arkademi_test/commons/enum/curriculum_type.dart';
import 'package:arkademi_test/domain/entities/curriculum_status.dart';
import 'package:arkademi_test/domain/entities/entities.dart';

final coursesStatusDummyJsonData = {
  "course_name": "Akuntansi dasar",
  "progress": "38",
  "curriculum": listCurriculumDummyJsonData
};

final coursesStatusDummyModelData = CoursesStatus(
  courseName: "Akuntansi dasar",
  progress: "38",
  curriculum: listCurriculumDummyModelData,
);

final listCurriculumDummyJsonData = [
  curriculumDummyJsonData,
  curriculumDummyJsonData,
];

final listCurriculumDummyModelData = <Curriculum>[
  curriculumDummyModelData.copyWith(type: CurriculumType.section),
  curriculumDummyModelData.copyWith(key: 1),
];

final listCurriculumStatusDummyModelData = <CurriculumStatus>[
  curriculumStatusDummyModelData.copyWith(isCurrent: true),
  curriculumStatusDummyModelData.copyWith(
      curriculum: curriculumDummyModelData.copyWith(key: 1)),
];

const curriculumStatusDummyModelData = CurriculumStatus(
  key: 0,
  isCompleted: false,
  isCurrent: false,
  isOffline: false,
  curriculum: curriculumDummyModelData,
  offlineVideoPath: null,
);

const curriculumStatusDummyJsonData = {
  "key": 0,
  "is_completed": false,
  "is_current": false,
  "is_offline": false,
  "curriculum": curriculumDummyJsonData,
  "offline_video_path": null
};

const curriculumDummyModelData = Curriculum(
  key: 0,
  id: 0,
  type: CurriculumType.unit,
  title: "1 - PENGANTAR",
  duration: 0,
  content: "",
  meta: [],
  status: 1,
  onlineVideoLink: "http://onlinevideolink",
  offlineVideoLink: "http://offlinevideolink",
);

const curriculumDummyJsonData = {
  "key": 0,
  "id": 0,
  "type": "unit",
  "title": "1 - Pengantar",
  "duration": 0,
  "content": "",
  "meta": [],
  "status": 1,
  "online_video_link": "http://onlinevideolink",
  "offline_video_link": "http://offlinevideolink"
};
