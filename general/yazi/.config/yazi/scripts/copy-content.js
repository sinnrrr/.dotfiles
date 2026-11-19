ObjC.import('AppKit');

function itemFor(path) {
  const item = $.NSPasteboardItem.alloc.init;
  const image = $.NSImage.alloc.initWithContentsOfFile(path);
  if (!image.isNil()) {
    const tiff = image.TIFFRepresentation;
    const png = $.NSBitmapImageRep.imageRepWithData(tiff).representationUsingTypeProperties($.NSBitmapImageFileTypePNG, $());
    item.setDataForType(png, 'public.png');
    item.setDataForType(tiff, 'public.tiff');
    return item;
  }
  const text = $.NSString.stringWithContentsOfFileEncodingError(path, $.NSUTF8StringEncoding, null);
  if (!text.isNil()) {
    item.setStringForType(text, 'public.utf8-plain-text');
    return item;
  }
  item.setStringForType($.NSURL.fileURLWithPath(path).absoluteString, 'public.file-url');
  return item;
}

function run(paths) {
  const items = $.NSMutableArray.array;
  paths.forEach(p => items.addObject(itemFor(p)));
  const pb = $.NSPasteboard.generalPasteboard;
  pb.clearContents;
  if (!pb.writeObjects(items)) throw new Error('Cannot write to clipboard');
}
