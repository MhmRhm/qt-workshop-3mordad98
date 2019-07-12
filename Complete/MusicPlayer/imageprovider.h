#ifndef IMAGEPROVIDER_H
#define IMAGEPROVIDER_H

#include <QQuickImageProvider>
#include <taglib/taglib.h>
#include <taglib/mpegfile.h>
#include <taglib/mpegproperties.h>
#include <taglib/id3v2tag.h>
#include <taglib/attachedpictureframe.h>

class ImageProvider : public QQuickImageProvider
{
public:
	explicit ImageProvider();
	virtual QPixmap requestPixmap(const QString &path, QSize *size, const QSize& requestedSize);
};

#endif // IMAGEPROVIDER_H
