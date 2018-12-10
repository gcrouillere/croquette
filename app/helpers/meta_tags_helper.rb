module MetaTagsHelper
  def meta_title
    content_for?(:title_tag) ? content_for(:title_tag) : "Vente de croquette et garde d'animaux à Sautron- La Tournée des Moustaches"
  end

  def meta_product_name
    content_for?(:meta_product_name) ? content_for(:meta_product_name) : "La Tournée des Moustaches"
  end

  def meta_description
    description = "Service de visite à domicile pour chats, chiens & Cie. Vente en ligne d'une gamme de croquettes 100% naturelles pour prendre soin de vos chiens et chats."
    content_for?(:description) ? content_for(:description) : description
  end

  def meta_image
    meta_image = (content_for?(:meta_image) ? content_for(:meta_image).strip : image_path(ENV['LOGOSITE']))
    # little twist to make it work equally with an asset or a url
    meta_image.starts_with?("http") ? meta_image : image_url(meta_image)
  end

  def meta_no_index
    content_for(:noindex) if content_for?(:noindex)
  end
end

