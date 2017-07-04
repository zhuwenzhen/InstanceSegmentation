#!/usr/bin/env wolframscript
(* ::Package:: *)

data = Association /@ instanceTrain[[1,2,1;;604907]];
imgIdList = #["image_id"] &/@ data;
bboxList = #["bbox"]&/@ data;
maskCoordList = #["segmentation"] &/@data;
dir = "/Users/wenzhen/Documents/Projects/InstanceSegmentation/";



Do[
	(*1. Import image i*)
	imageId = imgIdList[[i]];
	image = Import[dir <>"coco/train2014/COCO_train2014_"<> padZero @ imageId<>".jpg"];
	bbox = bboxList[[i]];

	maskCoord = maskCoordList[[i]];
	{imgTrim, maskTrim} = extractBBoxAndMask[image, bbox, maskCoord];
	Export[dir <> "coco/myTrain/bbox/bbox_"<> padZero@imageId<> ".jpg",imgTrim];
	Export[dir <> "coco/myTrain/mask/mask_"<> padZero@imageId<> ".jpg",maskTrim];
	Dynamic[Print[i]];
	,
{i, 24969, 25000, 1}]
